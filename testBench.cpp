#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include "Vtb.h"

uint64_t main_time = 0;

double sc_time_stamp()
{
    return main_time;
}

class Test
{
private:
    Vtb *top;
    VerilatedVcdC *tfp;
    int reset = 0;
    int p_reset = 0;

public:
    unsigned int m_clock_count = 0;
    Test()
    {
        top = new Vtb;
        tfp = new VerilatedVcdC;
        top->trace(tfp, 99);
        tfp->open("wave.vcd");
        resetCore();
    }
    ~Test(void)
    {
        tfp->close();
        top->final();
    };
    unsigned long long tick(void)
    {
#define REFCYC 1000 // per 10ps
#define SDRCYC 500  // per 10ps
        static int refclkCnt = 0, sdrclkCnt = SDRCYC - REFCYC;
        refclkCnt++;
        sdrclkCnt++;
        if (refclkCnt == REFCYC)
        {
            top->m_clock = !top->m_clock;
            refclkCnt = 0;
        }
        if (sdrclkCnt == SDRCYC)
        {
            top->sdrclk = !top->sdrclk;
            top->sdrclk1 = !top->sdrclk1;
            sdrclkCnt = 0;
        }
        return m_clock_count++;
    };
    void eval(void)
    {
        top->eval();
        main_time++;
    };
    void dump(void)
    {
        tfp->dump(m_clock_count);
    };
    void step(void)
    {
        tick();
        eval();
        dump();
    };
    void resetCore(void)
    {
        top->p_reset = 0;

        while (tick() <= REFCYC)
        {
            eval();
            dump();
        }
        /* assert reset signal for one clock cycle */
        {
            top->p_reset = 1;
            eval();
            dump();

            tick();
            eval();
            dump();
        }
        /* negate reset signal */
        {
            tick();
            eval();
            dump();
        }
    };
};

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    Test *test;
    test = new Test;
    while (1)
    {
        test->step();
    }
    delete test;
}