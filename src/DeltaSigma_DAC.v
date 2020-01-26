/********************************************************
 * Title    : Delta Sigma D/A module
 * Date     : 2016/09/08
 * Design   : kingyo
 ********************************************************/

// DA分解能(bit)
localparam	RESO = 6;

module DeltaSigma_DAC (
    input   wire    i_clk,
    input   wire    i_res_n,
    input   wire    [RESO - 1:0]    i_adata,
    output  wire    o_out
    );	
    
    reg     [RESO:0]    sigma;

    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            sigma <= 0;
        end else begin
            sigma <= sigma[RESO-1:0] + i_adata;
        end	
    end
    assign	o_out = sigma[RESO];
    
endmodule
