#include <msp430.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <mspReseter.h>
#include <mspProfiler.h>
#include <mspDebugger.h>
#include <mspbase.h>

#include <coala.h>

//#define TSK_SIZ
//#define AUTO_RST
//#define LOG_INFO
#define RAISE_PIN

//#define DEBUG 1

#define MSG "hello"
#define MSG_LEN 5

// Debug defines and flags.
#define DEBUG_PORT 3
#define DEBUG_PIN  4
__nv uint8_t full_run_started = 0;

char * msgPt = MSG;


// Tasks.
COALA_TASK(initTask, 3)
COALA_TASK(ce_1, 1)
COALA_TASK(ce_2, 1)
COALA_TASK(is_i_prime, 4)
COALA_TASK(ce_3, 1)
COALA_TASK(cd, 5)
COALA_TASK(ce_4, 1)
COALA_TASK(encrypt_init, 1)
COALA_TASK(encrypt_inner_loop, 1)
COALA_TASK(encrypt_finish, 1)
COALA_TASK(encrypt_print, 1)
COALA_TASK(decrypt_init, 1)
COALA_TASK(decrypt_inner_loop, 1)
COALA_TASK(decrypt_finish, 1)
COALA_TASK(decrypt_print, 1)

// Task-shared protected variables.
__p long int p, q, n, t, k, j, i, flag;
__p long int e[10], d[10], m[10], temp[10], en[10];
__p long int en_pt, en_ct = 0, en_key, en_k, en_cnt, en_j = 0;
__p long int de_pt, de_ct = 0, de_key, de_k, de_cnt, de_j = 0;


void init()
{
    msp_watchdog_disable();
    msp_gpio_unlock();

#ifdef RAISE_PIN
    msp_gpio_clear(DEBUG_PORT, 4);
    msp_gpio_clear(DEBUG_PORT, 5);
    msp_gpio_clear(DEBUG_PORT, 6);
    msp_gpio_dir_out(DEBUG_PORT, 4);
    msp_gpio_dir_out(DEBUG_PORT, 5);
    msp_gpio_dir_out(DEBUG_PORT, 6);
#endif

    // msp_clock_set_mclk(CLK_8_MHZ);

#ifdef TSK_SIZ
    cp_init();
#endif

#ifdef LOG_INFO
    uart_init();
#endif

#ifdef AUTO_RST
    mr_auto_rand_reseter(25000); // every 12 msec the MCU will be reseted
#endif

}

void initTask()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    full_run_started = 1;

#ifdef DEBUG
    uart_sendText("Start\n\r", 7);
    uart_sendText("\n\r", 2);
#endif

    int in_p = 7;
    int in_q = 17;

    WP(p)= in_p;
    WP(q)= in_q;
    WP(n)= in_p * in_q;
    WP(t)= (in_p-1) * (in_q-1);
    WP(i)=1;
    WP(k)=0;
    WP(flag)=0;
    for (int ii = 0; ii < MSG_LEN; ii++)
    {
        WP(m[ii]) = *(msgPt+ii);
    }

#ifdef TSK_SIZ
    cp_sendRes ("initTask \0");
#endif

    coala_next_task(ce_1);
}

void ce_1()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    WP(i)++; // start with i=2

    if (RP(i) >= RP(t)) {
        coala_next_task(encrypt_init);
    } else {
        coala_next_task(ce_2);
    }

#ifdef TSK_SIZ
    cp_sendRes ("ce_1 \0");
#endif
}

void ce_2()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    if (RP(t) % RP(i) == 0) {
        coala_next_task(ce_1);
    } else {
        coala_next_task(is_i_prime);
    }

#ifdef TSK_SIZ
    cp_sendRes ("ce_2 \0");
#endif
}

void  is_i_prime()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    int c;
    c=sqrt(RP(i));
    WP(j) = c;
    for(c=2; c <= RP( j) ;c++)
    {
        if( RP(i) % c==0)
        {
            WP(flag)=0;
            coala_next_task(ce_1);
            return;
        }
    }
    WP(flag) = 1;

#ifdef TSK_SIZ
    cp_sendRes ("is_i_prime \0");
#endif

    coala_next_task(ce_3);
}

void ce_3()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    long int in_i = RP(i);
    if( RP(flag) == 1 && in_i != RP(p) && in_i != RP(q) )
    {
        WP(e[RP(k)]) = in_i ;
    } else {
        coala_next_task(ce_1);
        return;
    }

#ifdef TSK_SIZ
    cp_sendRes ("ce_3 \0");
#endif

    coala_next_task(cd);
}

void cd()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    long int kk=1, __cry;
    while(1)
    {
        kk=kk +  RP(t);
        if(kk % RP( e[RP(k)] ) ==0){
            __cry = (kk/ RP( e[ RP(k) ]) );
            WP(flag) = __cry;
            break;
        }
    }

#ifdef TSK_SIZ
    cp_sendRes ("cd \0");
#endif

    coala_next_task(ce_4);
}

void ce_4()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

    int __cry = RP(flag);
    if(__cry > 0)
    {
        WP(d[ RP(k) ]) =__cry;
        WP(k)++;
    }

    if (RP(k) < 9) {
        coala_next_task(ce_1);
    } else {
        coala_next_task(encrypt_init);
    }

#ifdef TSK_SIZ
    cp_sendRes ("ce_4 \0");
#endif
}

void encrypt_init()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

  long int __cry;
   __cry = RP(m[ RP(en_cnt) ]) ;
   WP(en_pt) = __cry;
   WP(en_pt) -=96;
   WP(en_k)  = 1;
   WP(en_j)  = 0;
   __cry = RP(e[0]) ;
   WP(en_key) = __cry;

#ifdef TSK_SIZ
    cp_sendRes ("encrypt_init \0");
#endif

    coala_next_task(encrypt_inner_loop);
}

void encrypt_inner_loop()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

   long int __cry;
    if (RP(en_j) < RP(en_key)) {
        __cry = RP(en_k) * RP(en_pt);
        WP(en_k) = __cry;
        __cry = RP(en_k) % RP(n);
        WP(en_k) = __cry;
        WP(en_j)++;
        coala_next_task(encrypt_inner_loop);
    } else {
        coala_next_task(encrypt_finish);
    }

#ifdef TSK_SIZ
    cp_sendRes ("encrypt_inner_loop \0");
#endif
}

void encrypt_finish()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

   long int __cry;
   __cry = RP(en_k);
   WP(temp[ RP(en_cnt) ]) = __cry;
   __cry = RP(en_k) + 96;
   WP(en_ct) = __cry;
   __cry = RP(en_ct);
   WP(en[ RP(en_cnt) ]) = __cry;

    if (RP(en_cnt) < MSG_LEN) {
        WP(en_cnt)++;
        coala_next_task(encrypt_init);
    } else {
        WP(en[ RP(en_cnt) ]) = -1;
        coala_next_task(encrypt_print);
    }

#ifdef TSK_SIZ
    cp_sendRes ("encrypt_finish \0");
#endif
}

void encrypt_print()
{
#ifdef DEBUG
    uart_sendText("THE_ENCRYPTED_MESSAGE_IS\n\r", 26);
    for(en_cnt=0;en_cnt < MSG_LEN;en_cnt++){
        uart_sendChar(en[en_cnt]);
    }
    uart_sendText("\n\r", 2);
#endif

    coala_next_task(decrypt_init);
}
void decrypt_init()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

   long int __cry;
   WP(de_k)  = 1;
   WP(de_j)  = 0;
   __cry =d[0];
   WP(de_key) = __cry;

#ifdef TSK_SIZ
    cp_sendRes ("decrypt_init \0");
#endif

    coala_next_task(decrypt_inner_loop);
}

void decrypt_inner_loop()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif
   long int __cry;
   __cry =  RP(temp[ RP(de_cnt) ]);
   WP(de_ct) = __cry;

    if( RP(de_j) < RP(de_key) )
    {
        __cry = RP(de_k) * RP(de_ct);
        WP(de_k) = __cry;
        __cry = RP(de_k) % RP(n);
        WP(de_k) = __cry;
        WP(de_j)++;
        coala_next_task(decrypt_inner_loop);
    } else {
        coala_next_task(decrypt_finish);
    }

#ifdef TSK_SIZ
    cp_sendRes ("decrypt_inner_loop \0");
#endif

}

void decrypt_finish()
{
#ifdef TSK_SIZ
    cp_reset ();
#endif

   long int __cry;
   __cry = RP(de_k) + 96;
   WP(de_pt) = __cry;
   WP(m[ RP(de_cnt) ]) = __cry;

    if (RP(en[ RP(de_cnt) ]) != -1) {
        WP(de_cnt)++;
        coala_next_task(decrypt_init);
    } else {
        coala_next_task(decrypt_print);
    }

#ifdef TSK_SIZ
    cp_sendRes ("decrypt_print \0");
#endif
}

void decrypt_print()
{

#ifdef TSK_SIZ
    cp_reset ();
#endif

    coala_force_commit();

    if (full_run_started) {
        msp_gpio_spike(DEBUG_PORT, DEBUG_PIN);
        full_run_started = 0;
    }

    coala_force_commit();

    coala_next_task(initTask);

#ifdef TSK_SIZ
    cp_sendRes ("decrypt_finish \0");
#endif

#ifdef DEBUG
    uart_sendText("THE_DECRYPTED_MESSAGE_IS\n\r", 26);
    for(de_cnt=0;de_cnt < MSG_LEN ;de_cnt++){
        uart_sendChar(m[de_cnt]);
    }
    uart_sendText("\n\r", 2);
#endif
}


int main(void)
{
    init();

    coala_init(initTask);

    msp_gpio_spike(DEBUG_PORT, DEBUG_PIN);

    coala_run();

    return 0;
}
