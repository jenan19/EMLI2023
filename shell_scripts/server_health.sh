#!/bin/bash 
*********************************************************************
             Memory 
*********************************************************************
 
=> Physical Memory
 
Total\tUsed\tFree\t%Free
 
${TOTALBC}GB\t${USEDBC}GB \t${FREEBC}GB\t$(($FREEMEM * 100 / $TOTALMEM  ))%
 
=> Swap Memory
 
Total\tUsed\tFree\t%Free
 
${TOTALSBC}GB\t${USEDSBC}GB\t${FREESBC}GB\t$(($FREESWAP * 100 / $TOTALSWAP  ))%
