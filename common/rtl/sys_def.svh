/////////////////////////////////////////////////////////////////////////
//                                                                     //
//   Modulename :  sys_defs.svh                                        //
//                                                                     //
//  Description :  This file defines macros and data structures used   //
//                 throughout the processor.                           //
//                                                                     //
/////////////////////////////////////////////////////////////////////////

// `ifndef __SYS_DEFS_SVH__
`define __SYS_DEFS_SVH__


// all files should `include "sys_defs.svh" to at least define the timescale
`timescale 1ns/100ps


///////////////////////////////////
// ---- Starting Parameters ---- //
///////////////////////////////////

`define WIDTH 32
`define LENGTH 10
`define LENGTH_BITS $clog2(LENGTH)