.include "record-def.s"
.include "linux.s"

.equ ST_READ_BUFFER,8
.equ ST_FILEDES,12
.equ ST_WRITE_BUFFER,8
.section .text
.global read_record
.type read_record,@function

read_record:
    pushl %ebp
    movl %esp,%ebp

    pushl %ebx
    #保存ebx的值
    movl ST_FILEDES(%ebp),%ebx
    movl ST_READ_BUFFER(%ebp),%ecx
    movl $RECORD_SIZE,%edx
    movl $SYS_READ,%eax
    int $LINUX_SYSCALL

    popl %ebx
    
    movl %ebp,%esp
    popl %ebp
    ret

.global write_record
.type write_record,@function
write_record:
    pushl %ebp
    movl %esp,%ebp

    pushl %ebx
    movl $SYS_WRITE,%eax
    movl ST_FILEDES(%ebp),%ebx
    movl ST_WRITE_BUFFER(%ebp),%ecx
    movl $RECORD_SIZE,%edx
    int $LINUX_SYSCALL

    popl %ebx
    movl %ebp,%esp
    popl %ebp
    ret