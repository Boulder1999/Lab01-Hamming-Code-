module HD(
	code_word1,
	code_word2,
	out_n
);
input  [6:0]code_word1, code_word2;
output reg signed[5:0] out_n;

wire [6:0]code_word1, code_word2;
wire [2:0]w1_circle, w2_circle;
reg w1_error_bit, w2_error_bit; 
reg signed [3:0]w1_correct, w2_correct;


assign w1_circle[0]=code_word1[6]^code_word1[3]^code_word1[2]^code_word1[1];
assign w1_circle[1]=code_word1[5]^code_word1[3]^code_word1[2]^code_word1[0];
assign w1_circle[2]=code_word1[4]^code_word1[3]^code_word1[1]^code_word1[0];

assign w2_circle[0]=code_word2[6]^code_word2[3]^code_word2[2]^code_word2[1];
assign w2_circle[1]=code_word2[5]^code_word2[3]^code_word2[2]^code_word2[0];
assign w2_circle[2]=code_word2[4]^code_word2[3]^code_word2[1]^code_word2[0];


always@(*)
begin
	case(w1_circle)
	3'b111 : begin
		w1_error_bit=code_word1[3];
		w1_correct={~code_word1[3],code_word1[2],code_word1[1],code_word1[0]};
	end
	3'b110 : begin
		w1_error_bit=code_word1[0];
		w1_correct={code_word1[3],code_word1[2],code_word1[1],~code_word1[0]};
	end
	3'b011 : begin	
		w1_error_bit=code_word1[2];
		w1_correct={code_word1[3],~code_word1[2],code_word1[1],code_word1[0]};
	end
	3'b101:begin
		w1_error_bit=code_word1[1];
		w1_correct={code_word1[3],code_word1[2],~code_word1[1],code_word1[0]};
	end
	3'b010 : begin	
		w1_error_bit=code_word1[5];
		w1_correct={code_word1[3],code_word1[2],code_word1[1],code_word1[0]};
	end
	3'b001:begin
		w1_error_bit=code_word1[6];
		w1_correct={code_word1[3],code_word1[2],code_word1[1],code_word1[0]};
	end
	3'b100:begin	
		w1_error_bit=code_word1[4];
		w1_correct={code_word1[3],code_word1[2],code_word1[1],code_word1[0]};
	end
	
	endcase

end

always@(*)
begin
	case(w2_circle)
	3'b111 : begin
		w2_error_bit=code_word2[3];
		w2_correct={~code_word2[3],code_word2[2],code_word2[1],code_word2[0]};
	end
	3'b110 : begin
		w2_error_bit=code_word2[0];
		w2_correct={code_word2[3],code_word2[2],code_word2[1],~code_word2[0]};
	end
	3'b011 : begin	
		w2_error_bit=code_word2[2];
		w2_correct={code_word2[3],~code_word2[2],code_word2[1],code_word2[0]};
	end
	3'b101:begin
		w2_error_bit=code_word2[1];
		w2_correct={code_word2[3],code_word2[2],~code_word2[1],code_word2[0]};
	end
	3'b010:begin
		w2_error_bit=code_word2[5];
		w2_correct={code_word2[3],code_word2[2],code_word2[1],code_word2[0]};
	end
	3'b001:begin
		w2_error_bit=code_word2[6];
		w2_correct={code_word2[3],code_word2[2],code_word2[1],code_word2[0]};
	end
	3'b100:begin	
		w2_error_bit=code_word2[4];
		w2_correct={code_word2[3],code_word2[2],code_word2[1],code_word2[0]};
	end
	
	endcase

end

always@(*)
begin	
	case({w1_error_bit,w2_error_bit})
	2'b00:begin	
		out_n=w1_correct*2+w2_correct;
	end
	2'b01:begin	
		out_n=w1_correct*2-w2_correct;
	end
	2'b10:begin
		out_n=w1_correct-w2_correct*2;
	end
	2'b11:begin
		out_n=w1_correct+w2_correct*2;
	end
	/*default:begin	
		out_n=w1_correct*2+w2_correct;
	end*/
	endcase
end
	
endmodule
