MAX_TID = 65536 /* Maximum thread ID */

/* Structure representing a thread */
        .struct 0
        .align 2
Thread_lock:
        /* 1-byte mutex */
        .struct Thread_lock + 1
        
        .align 2
Thread_id:
        /* 4-byte identifier (also serves as an index into the thread table */
        .struct Thread_id + 4
        
        .align 2
Thread_state:
        /* 68-byte state:
                * 15 4-byte saved registers (not including the pc)
                * 8-byte "return state" (lr and cpsr) */
        .struct Thread_state + 68

        .align 2
        /* Boolean "privilege" flag (1 byte, non-zero if privileged) */
Thread_privileged:
        .struct Thread_privileged + 1
        
        .align 2
        /* Thread status */
Thread_status:
        .struct Thread_status + 1

        .align 2
        /* Pointer to a bitmask of thread IDs this thread is 
         * ready to receive from. (Only valid if this thread has
         * THREAD_STATUS_READY. */
Thread_recvmask:
        .struct Thread_recvmask + 4

        .align 2
Thread__size:

/* Possible values for Thread_status */
THREAD_STATUS_INVALID = 0 /* Thread in inconsistent state (during
                             initialization, etc.) */
THREAD_STATUS_WAITING = 1 /* waiting to receive a message */
THREAD_STATUS_READY = 2 /* ready to run */


.section .data
.align 2

.rept MAX_TID
.word NULL
.endr
