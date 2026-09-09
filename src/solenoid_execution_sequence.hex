using System;
using System.Collections.Generic;

namespace UnivacSolenoidMatrix
{
    public class SolenoidDriverCore
    {
        private Dictionary<ushort, byte> hardwareRegisters = new Dictionary<ushort, byte>();
        public bool ExecutionComplete { get; private set; } = false;

        public void WriteBusRegister(ushort subAddress, byte dataStream)
        {
            hardwareRegisters[subAddress] = dataStream;
        }

        public void EvaluateInstruction(ushort pc)
        {
            if (!hardwareRegisters.ContainsKey(pc)) return;

            byte operation = hardwareRegisters[pc];
            byte signalLine = hardwareRegisters.ContainsKey((ushort)(pc + 1)) ? hardwareRegisters[(ushort)(pc + 1)] : (byte)0x00;

            switch (operation)
            {
                case 0x41: // OP: VALVE_OPEN
                    Console.WriteLine($"[UNIVAC MANIFOLD 0x{pc:X4}]: OPCODE 41 - ENERGIZING SOLENOID MATRIX LINE. MASK: 0x{signalLine:X2}");
                    break;

                case 0x88: // OP: PURGE_CHAMBER
                    Console.WriteLine($"[UNIVAC MANIFOLD 0x{pc:X4}]: OPCODE 88 - OVERRIDE INDUCTION: EXECUTING PRESSURE FLUSH SEQUENCE.");
                    break;

                case 0x73: // OP: SAMPLING_METRICS
                    Console.WriteLine($"[UNIVAC MANIFOLD 0x{pc:X4}]: OPCODE 73 - BALANCING OPTICAL FLOW SENSOR COEFFICIENTS: REGISTERS LOCKED.");
                    break;

                case 0x00: // OP: SYSTEM_STOP
                    Console.WriteLine($"[UNIVAC MANIFOLD 0x{pc:X4}]: OPCODE 00 - FLUIDIC SYSTEM DISENGAGED SAFELY.");
                    ExecutionComplete = true;
                    break;

                default:
                    Console.WriteLine($"[UNIVAC MANIFOLD ERROR]: FAULT DETECTED AT ADDRESS BYTE 0x{operation:X2}");
                    break;
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            SolenoidDriverCore driver = new SolenoidDriverCore();

            byte[] compositeHexMap = new byte[] {
                0x41, 0x07,  // 0x0000: Open distribution paths 1, 2, and 3
                0x73, 0x1A,  // 0x0002: Sample fluid densities via optocouplers
                0x88, 0x00,  // 0x0004: Cycle high pressure flush routine
                0x00, 0x00   // 0x0006: Return lines to neutral safe states
            };

            for (ushort i = 0; i < compositeHexMap.Length; i++)
            {
                driver.WriteBusRegister(i, compositeHexMap[i]);
            }

            ushort instructionPointer = 0x0000;
            Console.WriteLine("=== TESTING FLUIDIC MANIFOLD PUMP CONTROL PROGRAM ===");

            while (!driver.ExecutionComplete && instructionPointer < compositeHexMap.Length)
            {
                driver.EvaluateInstruction(instructionPointer);
                instructionPointer += 2;
            }
        }
    }
}
