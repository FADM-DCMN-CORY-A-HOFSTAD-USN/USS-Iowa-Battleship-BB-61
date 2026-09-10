using System;
using System.Collections.Generic;

namespace UnivacMedicalCore
{
    public class UnivacIXController
    {
        // Simulated 12-bit/24-bit memory spaces matching historical word architectures
        private Dictionary<ushort, byte> memoryRegister = new Dictionary<ushort, byte>();
        public bool SystemHalt { get; private set; } = false;

        public void LoadProgramCode(ushort startAddress, byte[] machineCode)
        {
            for (ushort i = 0; i < machineCode.Length; i++)
            {
                memoryRegister[(ushort)(startAddress + i)] = machineCode[i];
            }
        }

        public void ExecuteInstructionCycle(ushort address)
        {
            if (!memoryRegister.ContainsKey(address)) return;

            byte opCode = memoryRegister[address];
            byte dataParam = memoryRegister.ContainsKey((ushort)(address + 1)) ? memoryRegister[(ushort)(address + 1)] : (byte)0x00;

            switch (opCode)
            {
                case 0x1A: // OP: INIT_CENTRIFUGE (BIOCHEM-970-1070 Setup)
                    Console.WriteLine($"[UNIVAC REG 0x{address:X4}]: OPCODE 1A - INITIALIZING APHERESIS MOTOR MATRIX. PARAM: 0x{dataParam:X2}");
                    break;

                case 0x5F: // OP: READ_PRESSURE (Verdura-Rx Hemoglobin Flow Monitor)
                    Console.WriteLine($"[UNIVAC REG 0x{address:X4}]: OPCODE 5F - SAMPLING FLUID LOOP DENSITY. TELEMETRY STABLE.");
                    break;

                case 0xEE: // OP: TRIGGER_BYPASS (BUMED Emergency Protocol Active)
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine($"[UNIVAC REG 0x{address:X4}]: OPCODE EE - OVERPRESSURE ENCOUNTERED. ENGAGING EMERGENCY DISCHARGE VALVE.");
                    Console.ResetColor();
                    break;

                case 0x00: // OP: HALT
                    Console.WriteLine($"[UNIVAC REG 0x{address:X4}]: OPCODE 00 - EXECUTION CYCLE COMPLETED safely.");
                    SystemHalt = true;
                    break;

                default:
                    Console.WriteLine($"[UNIVAC ERROR]: UNKNOWN MNEMONIC 0x{opCode:X2}");
                    break;
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            UnivacIXController coreProcessor = new UnivacIXController();

            // Hex instruction array processing device loops sequentially
            byte[] medicalSuiteProgram = new byte[] {
                0x1A, 0x01,  // Step 0: Initialize device arrays
                0x5F, 0xAC,  // Step 2: Read active flow status
                0xEE, 0xFF,  // Step 4: Validate emergency bounds
                0x00, 0x00   // Step 6: System line halt
            };

            coreProcessor.LoadProgramCode(0x0000, medicalSuiteProgram);

            ushort instructionPointer = 0x0000;
            Console.WriteLine("--- STARTING UNIVAC HOSPITAL SHIP PLATFORM SIMULATION ENGINE ---");
            
            while (!coreProcessor.SystemHalt && instructionPointer < medicalSuiteProgram.Length)
            {
                coreProcessor.ExecuteInstructionCycle(instructionPointer);
                instructionPointer += 2; // Increments via two-byte word strides
            }
        }
    }
}
