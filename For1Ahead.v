`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 07:36:39 AM
// Design Name: 
// Module Name: For1Ahead
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
/*
ForwardA = ForwardB = 00 //initialize
IF (EX/MEM.RegisterRd == ID/EX.RegisterRs) ForwardA = 10
IF (EX/MEM.RegisterRd == ID/EX.RegisterRt) ForwardB = 10
IF (EX/MEM.RegisterRd ~= ID/EX.RegisterRs &&
 MEM/WB.RegisterRd == ID/EX.RegisterRs) ForwardA = 01
IF (EX/MEM.RegisterRd ~= ID/EX.RegisterRt &&
 MEM/WB.RegisterRd == ID/EX.RegisterRt) ForwardB = 01
*/
module For1Ahead(
    ForwardA,
    ForwardB,
    MemDest,
    IDEX_Rs,
    IDEX_Rt,
    WriteBackDest,
    MEM_RegWrite,
    RegWriteWB
    );
    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;
    input [4:0] MemDest, IDEX_Rs, IDEX_Rt;
    input [4:0] WriteBackDest;
    input MEM_RegWrite, RegWriteWB;
    
    always @(*) begin
        // Default values
        ForwardA = 2'b00;
        ForwardB = 2'b00;

        // Forwarding logic
        if(MemDest == IDEX_Rs && MEM_RegWrite && MemDest != 0)  
            ForwardA = 2'b10;
        else if(WriteBackDest == IDEX_Rs && RegWriteWB && WriteBackDest != 0)  
            ForwardA = 2'b01;
            
        if(MemDest == IDEX_Rt && MEM_RegWrite && MemDest != 0)  
            ForwardB = 2'b10;
        else if(WriteBackDest == IDEX_Rt && RegWriteWB && WriteBackDest != 0)  
            ForwardB = 2'b01;
    end
endmodule
