module huffman(
  // Input signals  
  clk, 
  rst_n, 
  in_valid, 
  gray_data, 
  // Output signals
  CNT_valid, 
  CNT1, 
  CNT2, 
  CNT3, 
  CNT4, 
  CNT5, 
  CNT6,
  code_valid, 
  HC1, 
  HC2, 
  HC3, 
  HC4, 
  HC5, 
  HC6, 
  M1, 
  M2, 
  M3, 
  M4, 
  M5, 
  M6
  
);

input clk;
input rst_n;
input in_valid;
input [7:0] gray_data;


output logic CNT_valid;
output logic [7:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
output logic code_valid;
output logic [7:0] HC1, HC2, HC3, HC4, HC5, HC6;
output logic [7:0] M1, M2, M3, M4, M5, M6;

logic [14:0] Huf1,Huf2,Huf3,Huf4,Huf5,Huf6;
logic [14:0] Huf1_sort,Huf2_sort,Huf3_sort,Huf4_sort,Huf5_sort,Huf6_sort;
logic [14:0] Huf1_ns,Huf2_ns,Huf3_ns,Huf4_ns,Huf5_ns,Huf6_ns;
logic [6:0] CNT1_temp,CNT2_temp,CNT3_temp,CNT4_temp,CNT5_temp,CNT6_temp;
logic [6:0] CNT1_temp_ns,CNT2_temp_ns,CNT3_temp_ns,CNT4_temp_ns,CNT5_temp_ns,CNT6_temp_ns;
logic [4:0] HC1_temp, HC2_temp, HC3_temp, HC4_temp, HC5_temp, HC6_temp;
logic [4:0] HC1_temp_ns, HC2_temp_ns, HC3_temp_ns, HC4_temp_ns, HC5_temp_ns, HC6_temp_ns;
logic [4:0] M1_temp, M2_temp, M3_temp, M4_temp, M5_temp, M6_temp;
logic [4:0] M1_temp_ns, M2_temp_ns, M3_temp_ns, M4_temp_ns, M5_temp_ns, M6_temp_ns;
logic [1:0] current_state,next;
logic round1,round1_ns,round2,round2_ns;

parameter
IDLE      = 2'b00,
COUNT_PRO = 2'b01,
HUFFMAN   = 2'b11;

parameter
C0 = 2'b00,
C1 = 2'b01,
C2 = 2'b10,
C3 = 2'b11;

CN SORT (Huf6_sort,Huf5_sort,Huf4_sort,Huf3_sort,Huf2_sort,Huf1_sort,Huf6_ns,Huf5_ns,Huf4_ns,Huf3_ns,Huf2_ns,Huf1_ns);

always_comb begin
  CNT_valid = 0;
  code_valid = 0;
  CNT1 = 0; 
  CNT2 = 0;
  CNT3 = 0;
  CNT4 = 0;
  CNT5 = 0;
  CNT6 = 0;
  HC1 = 0;
  HC2 = 0;
  HC3 = 0;
  HC4 = 0;
  HC5 = 0;
  HC6 = 0;
  M1 = 0;
  M2 = 0;
  M3 = 0;
  M4 = 0;
  M5 = 0;
  M6 = 0;
  CNT1_temp_ns = CNT1_temp;
  CNT2_temp_ns = CNT2_temp;
  CNT3_temp_ns = CNT3_temp;
  CNT4_temp_ns = CNT4_temp;
  CNT5_temp_ns = CNT5_temp;
  CNT6_temp_ns = CNT6_temp;
  HC1_temp_ns = HC1_temp;
  HC2_temp_ns = HC2_temp;
  HC3_temp_ns = HC3_temp;
  HC4_temp_ns = HC4_temp;
  HC5_temp_ns = HC5_temp;
  HC6_temp_ns = HC6_temp;
  M1_temp_ns = M1_temp;
  M2_temp_ns = M2_temp;
  M3_temp_ns = M3_temp;
  M4_temp_ns = M4_temp;
  M5_temp_ns = M5_temp;
  M6_temp_ns = M6_temp;
  Huf1_sort = {CNT1_temp,C3,6'b10_0000};
  Huf2_sort = {CNT2_temp,C3,6'b01_0000};
  Huf3_sort = {CNT3_temp,C3,6'b00_1000};
  Huf4_sort = {CNT4_temp,C3,6'b00_0100};
  Huf5_sort = {CNT5_temp,C3,6'b00_0010};
  Huf6_sort = {CNT6_temp,C3,6'b00_0001};
  round1_ns = 0;
  round2_ns = 0;
  next = IDLE;

  if (gray_data[2]) begin
    if (gray_data[1]) begin 
      CNT6_temp_ns = CNT6_temp + 1;
    end
    else begin
      if (gray_data[0]) begin 
        CNT5_temp_ns = CNT5_temp + 1; 
      end
      else begin 
        CNT4_temp_ns = CNT4_temp + 1;
      end
    end
  end
  else begin
    if (gray_data[1]) begin
      if (gray_data[0]) begin 
        CNT3_temp_ns = CNT3_temp + 1; 
      end
      else begin 
        CNT2_temp_ns = CNT2_temp + 1;
      end
    end
    else begin
      if (gray_data[0]) begin 
        CNT1_temp_ns = CNT1_temp + 1; 
      end
    end
  end

  case (current_state)
    IDLE : begin 
      HC1_temp_ns = 0;
      HC2_temp_ns = 0;
      HC3_temp_ns = 0;
      HC4_temp_ns = 0;
      HC5_temp_ns = 0;
      HC6_temp_ns = 0;
      M1_temp_ns = 0;
      M2_temp_ns = 0;
      M3_temp_ns = 0;
      M4_temp_ns = 0;
      M5_temp_ns = 0;
      M6_temp_ns = 0;
      if (in_valid) next = COUNT_PRO;
      else begin
        CNT1_temp_ns = 0;
        CNT2_temp_ns = 0;
        CNT3_temp_ns = 0;
        CNT4_temp_ns = 0;
        CNT5_temp_ns = 0;
        CNT6_temp_ns = 0;
      end
    end
    COUNT_PRO : begin
      next = current_state;
      if (!in_valid) next = HUFFMAN;
    end
    HUFFMAN : begin
      next = current_state;
      round1_ns = 1;
      round2_ns = round1;

      Huf6_sort = ~(Huf6 & 0);
      Huf5_sort = Huf6;
      Huf4_sort = Huf5;
      Huf3_sort = Huf4;
      Huf2_sort = Huf3;
      Huf1_sort[14:8] = Huf1[14:8] + Huf2[14:8];
      Huf1_sort[5:0] = Huf1[5:0] + Huf2[5:0];
      Huf1_sort[7:6] = C2;
      if (round1) Huf1_sort[7:6] = C1;
      else begin
        CNT_valid = 1;
        CNT1 = {1'b0,CNT1_temp};
        CNT2 = {1'b0,CNT2_temp};
        CNT3 = {1'b0,CNT3_temp};
        CNT4 = {1'b0,CNT4_temp};
        CNT5 = {1'b0,CNT5_temp};
        CNT6 = {1'b0,CNT6_temp};
      end
      if (round2) Huf1_sort[7:6] = C0;

      if (Huf1[5]) begin 
        if (M1_temp[3]) HC1_temp_ns[4] = 1;
        else if (M1_temp[2]) HC1_temp_ns[3] = 1;
        else if (M1_temp[1]) HC1_temp_ns[2] = 1;
        else if (M1_temp[0]) HC1_temp_ns[1] = 1;
        else HC1_temp_ns[0] = 1;
      end
      if (Huf1[4]) begin 
        if (M2_temp[3]) HC2_temp_ns[4] = 1;
        else if (M2_temp[2]) HC2_temp_ns[3] = 1;
        else if (M2_temp[1]) HC2_temp_ns[2] = 1;
        else if (M2_temp[0]) HC2_temp_ns[1] = 1;
        else HC2_temp_ns[0] = 1; 
      end      
      if (Huf1[3]) begin 
        if (M3_temp[3]) HC3_temp_ns[4] = 1;
        else if (M3_temp[2]) HC3_temp_ns[3] = 1;
        else if (M3_temp[1]) HC3_temp_ns[2] = 1;
        else if (M3_temp[0]) HC3_temp_ns[1] = 1;
        else HC3_temp_ns[0] = 1; 
      end
      if (Huf1[2]) begin 
        if (M4_temp[3]) HC4_temp_ns[4] = 1;
        else if (M4_temp[2]) HC4_temp_ns[3] = 1;
        else if (M4_temp[1]) HC4_temp_ns[2] = 1;
        else if (M4_temp[0]) HC4_temp_ns[1] = 1;
        else HC4_temp_ns[0] = 1;  
      end
      if (Huf1[1]) begin 
        if (M5_temp[3]) HC5_temp_ns[4] = 1;
        else if (M5_temp[2]) HC5_temp_ns[3] = 1;
        else if (M5_temp[1]) HC5_temp_ns[2] = 1;
        else if (M5_temp[0]) HC5_temp_ns[1] = 1;
        else HC5_temp_ns[0] = 1;  
      end
      if (Huf1[0]) begin 
        if (M6_temp[3]) HC6_temp_ns[4] = 1;
        else if (M6_temp[2]) HC6_temp_ns[3] = 1;
        else if (M6_temp[1]) HC6_temp_ns[2] = 1;
        else if (M6_temp[0]) HC6_temp_ns[1] = 1;
        else HC6_temp_ns[0] = 1;  
      end

      if (Huf1[5] | Huf2[5]) begin 
        if (M1_temp[3]) M1_temp_ns[4] = 1;
        else if (M1_temp[2]) M1_temp_ns[3] = 1;
        else if (M1_temp[1]) M1_temp_ns[2] = 1;
        else if (M1_temp[0]) M1_temp_ns[1] = 1;
        else M1_temp_ns[0] = 1;
      end
      if (Huf1[4] | Huf2[4]) begin 
        if (M2_temp[3]) M2_temp_ns[4] = 1;
        else if (M2_temp[2]) M2_temp_ns[3] = 1;
        else if (M2_temp[1]) M2_temp_ns[2] = 1;
        else if (M2_temp[0]) M2_temp_ns[1] = 1;
        else M2_temp_ns[0] = 1; 
      end      
      if (Huf1[3] | Huf2[3]) begin 
        if (M3_temp[3]) M3_temp_ns[4] = 1;
        else if (M3_temp[2]) M3_temp_ns[3] = 1;
        else if (M3_temp[1]) M3_temp_ns[2] = 1;
        else if (M3_temp[0]) M3_temp_ns[1] = 1;
        else M3_temp_ns[0] = 1; 
      end
      if (Huf1[2] | Huf2[2]) begin 
        if (M4_temp[3]) M4_temp_ns[4] = 1;
        else if (M4_temp[2]) M4_temp_ns[3] = 1;
        else if (M4_temp[1]) M4_temp_ns[2] = 1;
        else if (M4_temp[0]) M4_temp_ns[1] = 1;
        else M4_temp_ns[0] = 1;  
      end
      if (Huf1[1] | Huf2[1]) begin 
        if (M5_temp[3]) M5_temp_ns[4] = 1;
        else if (M5_temp[2]) M5_temp_ns[3] = 1;
        else if (M5_temp[1]) M5_temp_ns[2] = 1;
        else if (M5_temp[0]) M5_temp_ns[1] = 1;
        else M5_temp_ns[0] = 1;  
      end
      if (Huf1[0] | Huf2[0]) begin 
        if (M6_temp[3]) M6_temp_ns[4] = 1;
        else if (M6_temp[2]) M6_temp_ns[3] = 1;
        else if (M6_temp[1]) M6_temp_ns[2] = 1;
        else if (M6_temp[0]) M6_temp_ns[1] = 1;
        else M6_temp_ns[0] = 1;  
      end


      if (Huf1_sort[14] & Huf1_sort[13] & Huf1_sort[10]) begin
      next = IDLE;
      code_valid = 1;
      M1[4:0] = M1_temp_ns;
      M2[4:0] = M2_temp_ns;
      M3[4:0] = M3_temp_ns;
      M4[4:0] = M4_temp_ns;
      M5[4:0] = M5_temp_ns;
      M6[4:0] = M6_temp_ns;

      HC1[4:0] = HC1_temp_ns;
      HC2[4:0] = HC2_temp_ns;
      HC3[4:0] = HC3_temp_ns;
      HC4[4:0] = HC4_temp_ns;
      HC5[4:0] = HC5_temp_ns;
      HC6[4:0] = HC6_temp_ns;
      end
    end
  endcase 
end

always_ff @(posedge clk) begin
    Huf6 <= Huf6_ns;
    Huf5 <= Huf5_ns;
    Huf4 <= Huf4_ns;
    Huf3 <= Huf3_ns;
    Huf2 <= Huf2_ns;
    Huf1 <= Huf1_ns;
end
always_ff @(posedge clk) begin
    round1 <= round1_ns;
    round2 <= round2_ns;
end
always_ff @(posedge clk) begin
    CNT1_temp <= CNT1_temp_ns;
    CNT2_temp <= CNT2_temp_ns;
    CNT3_temp <= CNT3_temp_ns;
    CNT4_temp <= CNT4_temp_ns;
    CNT5_temp <= CNT5_temp_ns;
    CNT6_temp <= CNT6_temp_ns;
end
always_ff @(posedge clk) begin
    HC1_temp <= HC1_temp_ns;
    HC2_temp <= HC2_temp_ns;
    HC3_temp <= HC3_temp_ns;
    HC4_temp <= HC4_temp_ns;
    HC5_temp <= HC5_temp_ns;
    HC6_temp <= HC6_temp_ns;
end
always_ff @(posedge clk) begin
    M1_temp <= M1_temp_ns;
    M2_temp <= M2_temp_ns;
    M3_temp <= M3_temp_ns;
    M4_temp <= M4_temp_ns;
    M5_temp <= M5_temp_ns;
    M6_temp <= M6_temp_ns;
end
always_ff @(posedge clk,negedge rst_n) begin
  if (!rst_n) current_state <= IDLE;
  else current_state <= next;
end

endmodule

module CN(number1,number2,number3,number4,number5,number6,s_number6,s_number5,s_number4,s_number3,s_number2,s_number1);

	input [14:0] number1, number2, number3, number4, number5, number6;
	output logic [14:0] s_number1, s_number2, s_number3, s_number4, s_number5, s_number6;
	logic [14:0] w1,w2,w3,w4,w5,w6,w7,w8,w9,w10;

	always_comb begin
		if(number1 > number2) begin
            w1 = (number2 > number3) ? number3 : number2;
            w2 = (number2 > number3) ? number2 : number3;
            w3 = number1;
		end 
        else begin
            w1 = (number1 > number3) ? number3 : number1;
            w2 = (number1 > number3) ? number1 : number3;
            w3 = number2;
		end
	end
	
	always_comb begin
		if(number5 > number6) begin
            w4 = (number4 > number6) ? number6 : number4;
            w5 = (number4 > number6) ? number4 : number6;
            w6 = number5;
		end 
        else begin
            w4 = (number4 > number5) ? number5 : number4;
            w5 = (number4 > number5) ? number4 : number5;
            w6 = number6;
		end
	end

    assign s_number3 = (w2 > w3) ? w2 : w3;
    assign w7 = (w2 > w3) ? w3 : w2;

    assign s_number4 = (w5 > w6) ? w5 : w6;
    assign w8 = (w5 > w6) ? w6 : w5;

    assign w9 = (w1 > w4) ? w1 : w4;
    assign s_number1 = (w1 > w4) ? w4 : w1;

    assign s_number5 = (w7 > w8) ? w7 : w8;
    assign w10 = (w7 > w8) ? w8 : w7;

    assign s_number6 = (w9 > w10) ? w9 : w10;
    assign s_number2 = (w9 > w10) ? w10 : w9;

endmodule