**STM32F103 Assembly Blink**

This code written with assembly and a simple linker for need of a bare minimum project



To build:

```bash
arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m3 -mthumb core.S -o core.o
```

```bash
arm-none-eabi-gcc core.o -mcpu=cortex-m3 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T./stm32f103c8t6.ld -o main.elf
```

To flash:

```bash
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program main.elf verify reset exit"
```
