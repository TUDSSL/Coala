# Coala : Dynamic Task-Based Intermittent Execution for Energy-Harvesting Devices

Coala is a task-based programming and executing model for energy-harvesting 
battery-less devices. Coala applications should be written a chain of tasks. 
Coala runtime library protects applications data against power interrupts.

Programming interface
---------------------
* A Coala's task should be declared as `COALA_TASK(<task name>, <task weight>)`.
* A global Coala's variable should be declared as `COALA_PV(<data type>, var)`.
* A global protected variable should be accessed with `WP(var)` for write and 
`RP(var)` for read. 
* The macro `coala_next_task(<next task>)` should be used to transition from one 
task to another.
* Coala's scheduler is invoked with `coala_run()`


Linker modification 
---------------------
Change
```
ROM (rx)         : ORIGIN = 0x4400, LENGTH = 0xBB80 /* END=0xFF7F, size 48000 */
```

with 
```
ROM (rx)         : ORIGIN = 0x4400, LENGTH = 0x7B70 /* END=0xBF7F, size 48000 */
PRS (rx)         : ORIGIN = 0xBF70, LENGTH = 0x400f /* END=0xFF7F, size 8016 */
```


Developing applications with Coala
-----------------------------------
* Coala library and applications can be build with GCC or Clang. 
* To build an application `cd` to `Coala-Repo\apps\<app>` and write `Make`. 
* To build Coala library `cd` to `Coala-Repo\coala` write `Make`.
* Coala's repository structure:
```
Coala-Repo
│
├── apps
│   └── app
│        ├── app.c
│        └── Makefile
├── coala
│   ├── Makefile
│   ├── include
│   ├── linkerScripts
│   └── src
├── libs
├── maker
└── targetConfigs
    └── MSP430FR5969.ccxml
```








