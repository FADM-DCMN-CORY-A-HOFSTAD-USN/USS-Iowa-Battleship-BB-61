// File: docs/hardware/firmware/hex_control/biochem_processor.cs
using System;
using System.Collections.Generic;

namespace UnivacBiochemValidationSuite
{
    public class UnivacIXHardwareEmulator
    {
        private Dictionary<ushort, byte> coreMemorySpace = new Dictionary<ushort, byte>();
        public bool ProcessingHalted { get; private set; } = false;

        // Environmental State Telemetry
        public double MockShipRollAngle { get; set; } = 0.0;
        public double MockGForceImpact { get; set; } = 1.0;

        public void LoadIntelHexRecord(string hexLine)
        {
            if (string.IsNullOrWhiteSpace(hexLine) || !hexLine.StartsWith(":")) return;

            // Simple parsing framework for standard Intel HEX records
            byte byteCount = Convert.ToByte(hexLine.Substring(1, 2), 16);
            ushort address = Convert.ToUInt16(hexLine.Substring(3, 4), 16);
            byte recordType = Convert.ToByte(hexLine.Substring(7, 2), 16);

            if (recordType == 0x00) // Data Record Type
            {
                for (int i = 0; i < byteCount; i++)
                {
                    byte dataByte = Convert.ToByte(hexLine.Substring(9 + (i * 2), 2), 16);
                    coreMemorySpace[(ushort)(address + i)] = dataByte;
                }
            }
        }

        public void EvaluateInstructionFrame(ushort pc)
        {
            if (!coreMemorySpace.ContainsKey(pc)) return;

            byte opCode = coreMemorySpace[pc];
            byte dataParam = coreMemorySpace.ContainsKey((ushort)(pc + 1)) ? coreMemorySpace[(ushort)(pc + 1)] : (byte)0x00;

            switch (opCode)
            {
                case 0x3D: // SET_ROTOR_RPM
                    int targetRPM = dataParam * 25;
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP 3D (SET_ROTOR_RPM) -> Core Speed Locked at {targetRPM} RPM.");
                    if (Math.Abs(MockShipRollAngle) > 20.0)
                    {
                        Console.ForegroundColor = ConsoleColor.Yellow;
                        Console.WriteLine($" >> ENVIRONMENT ALERT: High Roll Detected ({MockShipRollAngle}°). Rotor balancing loops engaged.");
                        Console.ResetColor();
                    }
                    break;

                case 0xB5: // INCUBATOR_TEMP
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP B5 (INCUBATOR_TEMP) -> Target Thermal Node Set to {dataParam}°C.");
                    break;

                case 0x82: // SAMPLE_SPECTRO
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP 82 (SAMPLE_SPECTRO) -> Flow Density Byte Vector: 0x{dataParam:X2}");
                    break;

                case 0x52: // READ_THERMISTOR
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP 52 (READ_THERMISTOR) -> Direct ADC Channel Sample: 0x{dataParam:X2}");
                    break;

                case 0x9B: // ADJUST_PWM
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP 9B (ADJUST_PWM) -> Gate Driver Duty Matrix scaled to {dataParam} / 255.");
                    break;

                case 0xF1: // SAFETY_OVERRIDE
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP F1 (SAFETY_OVERRIDE) -> Verification Routine Triggered.");
                    if (MockGForceImpact > 3.5)
                    {
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine($" >> CRITICAL: Blast Force Shock detected ({MockGForceImpact}G). Tripping isolation shunt.");
                        Console.ResetColor();
                    }
                    break;

                case 0x00: // HALT
                    Console.WriteLine($"[UNIVAC RUN ADDR 0x{pc:X4}]: OP 00 (HALT) -> Separation Line Execution safely terminated.");
                    ProcessingHalted = true;
                    break;
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            UnivacIXHardwareEmulator validator = new UnivacIXHardwareEmulator();

            // Raw line strings mirroring biochem_separation_loop.hex payload
            string[] rawIntelHexRows = new string[] {
                ":020000003D96FB",
                ":02000200B52522",
                ":02000400821FE6",
                ":0200060052AC1B",
                ":020008009B4015",
                ":02000A00F1FF04",
                ":02000C000000F2",
                ":00000001FF"
            };

            foreach (var line in rawIntelHexRows)
            {
                validator.LoadIntelHexRecord(line);
            }

            // Establish Simulated Sea Conditions
            validator.MockShipRollAngle = 24.5; // Moderate wave-action list angle
            validator.MockGForceImpact = 4.2;   // Simulating immediate adjacent hull blast load forces

            ushort instructionPointer = 0x0000;
            Console.WriteLine("=== STARTING STABILIZATION & CONTROL SYSTEM EMULATION RUN ===");

            while (!validator.ProcessingHalted && instructionPointer <= 0x000C)
            {
                validator.EvaluateInstructionFrame(instructionPointer);
                instructionPointer += 2;
            }
        }
    }
}
