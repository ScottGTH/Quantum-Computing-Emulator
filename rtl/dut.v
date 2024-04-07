
`include "defines.vh"
//---------------------------------------------------------------------------
// DUT 
//---------------------------------------------------------------------------
module MyDesign(
//---------------------------------------------------------------------------
//System signals
  input wire reset_n                      ,  
  input wire clk                          ,

//---------------------------------------------------------------------------
//Control signals
  input wire dut_valid                    , 
  output reg dut_ready                   ,

//---------------------------------------------------------------------------
//q_state_input SRAM interface
  output wire                                               q_state_input_sram_write_enable  ,
  output wire [`Q_STATE_INPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_input_sram_write_address ,
  output wire [`Q_STATE_INPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_input_sram_write_data    ,
  output wire [`Q_STATE_INPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_input_sram_read_address  , 
  input  wire [`Q_STATE_INPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_input_sram_read_data     ,

//---------------------------------------------------------------------------
//q_state_output SRAM interface
  output wire                                                q_state_output_sram_write_enable  ,
  output wire [`Q_STATE_OUTPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_output_sram_write_address ,
  output wire [`Q_STATE_OUTPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_output_sram_write_data    ,
  output wire [`Q_STATE_OUTPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_output_sram_read_address  , 
  input  wire [`Q_STATE_OUTPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_output_sram_read_data     ,

//---------------------------------------------------------------------------
//scratchpad SRAM interface                                                       
  output wire                                                scratchpad_sram_write_enable        ,
  output wire [`SCRATCHPAD_SRAM_ADDRESS_UPPER_BOUND-1:0]     scratchpad_sram_write_address       ,
  output wire [`SCRATCHPAD_SRAM_DATA_UPPER_BOUND-1:0]        scratchpad_sram_write_data          ,
  output wire [`SCRATCHPAD_SRAM_ADDRESS_UPPER_BOUND-1:0]     scratchpad_sram_read_address        , 
  input  wire [`SCRATCHPAD_SRAM_DATA_UPPER_BOUND-1:0]        scratchpad_sram_read_data           ,

//---------------------------------------------------------------------------
//q_gates SRAM interface                                                       
  output wire                                                q_gates_sram_write_enable           ,
  output wire [`Q_GATES_SRAM_ADDRESS_UPPER_BOUND-1:0]        q_gates_sram_write_address          ,
  output wire [`Q_GATES_SRAM_DATA_UPPER_BOUND-1:0]           q_gates_sram_write_data             ,
  output wire [`Q_GATES_SRAM_ADDRESS_UPPER_BOUND-1:0]        q_gates_sram_read_address           ,  
  input  wire [`Q_GATES_SRAM_DATA_UPPER_BOUND-1:0]           q_gates_sram_read_data              
);

  
         




  localparam s0  = 3'b000;
  localparam s1  = 3'b001;
  localparam s2  = 3'b010;
  localparam s3  = 3'b011;
  localparam s4  = 3'b100;
  localparam s5  = 3'b101;
  localparam s6  = 3'b110;
  localparam s7  = 3'b111;
  localparam s8  = 4'b1000;
  localparam s9  = 4'b1001;
  localparam s10 = 4'b1010;
  localparam s11 = 4'b1011;
  localparam s12 = 4'b1100;
  localparam s13 = 4'b1101;
  localparam s14 = 4'b1110;
  localparam s15 = 4'b1111;
  localparam s16 = 5'b10000;

  localparam inst_sig_width = 52;
  localparam inst_exp_width = 11;
  localparam inst_ieee_compliance = 3;

  reg  [inst_sig_width+inst_exp_width : 0] inst_a;
  reg  [inst_sig_width+inst_exp_width : 0] inst_b;
  reg  [inst_sig_width+inst_exp_width : 0] inst_c;
  reg  [inst_sig_width+inst_exp_width : 0] inst_d;
  wire [inst_sig_width+inst_exp_width : 0] inst_1;
  wire [inst_sig_width+inst_exp_width : 0] inst_2;
  wire [inst_sig_width+inst_exp_width : 0] inst_3;
  wire [inst_sig_width+inst_exp_width : 0] inst_4;
  reg  [inst_sig_width+inst_exp_width : 0] a_a1;
  reg  [inst_sig_width+inst_exp_width : 0] a_b1;
  reg  [inst_sig_width+inst_exp_width : 0] a_a2;
  reg  [inst_sig_width+inst_exp_width : 0] a_b2;
  reg  [inst_sig_width+inst_exp_width : 0] a_a3;
  reg  [inst_sig_width+inst_exp_width : 0] a_b3;
  reg  [inst_sig_width+inst_exp_width : 0] a_a4;
  reg  [inst_sig_width+inst_exp_width : 0] a_b4;
  wire [inst_sig_width+inst_exp_width : 0] a_z1;
  wire [inst_sig_width+inst_exp_width : 0] a_z2;
  wire [inst_sig_width+inst_exp_width : 0] a_z3;
  wire [inst_sig_width+inst_exp_width : 0] a_z4;
  reg  [2 : 0] inst_rnd;
  wire [7 : 0] status_inst;

  reg [63:0] Q_size;
  reg [63:0] M_size;
  reg [127:0] counter_1;
  reg [127:0] counter_2;
  reg [127:0] counter_3;
  reg [127:0] counter_4;
  reg [127:0] counter_0;
  reg [127:0] counter_5;
  reg [127:0] counter_6;
  reg [127:0] counter_7;
reg [3:0] current_state;
  reg [3:0] next_state;
  
  reg [127:0] write;

  reg [1:0] Q_size_var;
  reg [1:0] q_state_input_sram_read_address_var;
  reg [1:0] q_gates_sram_read_address_var;
  reg [1:0] scratchpad_sram_read_address_var;
  reg [1:0] scratchpad_sram_write_address_var;
  reg [1:0] q_state_input_sram_write_address_var;
  reg [1:0] q_state_output_sram_write_address_var;
  reg [1:0] val_counter;
  reg [1:0] val_counter1;
  reg [1:0] val_counter2;
  reg [1:0] val_counter5;
  reg [1:0] val_counter7;
  reg [1:0] val_scratchpad_sram_write_data;
  reg [1:0] val_inst;
  reg val_add;
  reg [1:0] val_add_3;
  reg [1:0] val_q_state_input_sram_write_data;
  reg val_q_state_output_sram_write_data;


//q_state_input SRAM interface
   reg                                               q_state_input_sram_write_enable_r;  
   reg [`Q_STATE_INPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_input_sram_write_address_r; 
   reg [`Q_STATE_INPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_input_sram_write_data_r;    
   reg [`Q_STATE_INPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_input_sram_read_address_r;  
   

//---------------------------------------------------------------------------
//q_state_output SRAM interface
   reg                                                q_state_output_sram_write_enable_r;  
   reg [`Q_STATE_OUTPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_output_sram_write_address_r; 
   reg [`Q_STATE_OUTPUT_SRAM_DATA_UPPER_BOUND-1:0]    q_state_output_sram_write_data_r;
   reg [`Q_STATE_OUTPUT_SRAM_ADDRESS_UPPER_BOUND-1:0] q_state_output_sram_read_address_r;    
    
//---------------------------------------------------------------------------
//scratchpad SRAM interface                                                       
   reg                                                scratchpad_sram_write_enable_r;        
   reg [`SCRATCHPAD_SRAM_ADDRESS_UPPER_BOUND-1:0]     scratchpad_sram_write_address_r;       
   reg [`SCRATCHPAD_SRAM_DATA_UPPER_BOUND-1:0]        scratchpad_sram_write_data_r;          
   reg [`SCRATCHPAD_SRAM_ADDRESS_UPPER_BOUND-1:0]     scratchpad_sram_read_address_r;         
        

//---------------------------------------------------------------------------
//q_gates SRAM interface                                                       
                    
   reg [`Q_GATES_SRAM_ADDRESS_UPPER_BOUND-1:0]        q_gates_sram_read_address_r;          

  always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
		current_state <= 4'b0;
	end
	else begin
		current_state <= next_state;
		//q_gates_sram_write_enable_r = 0;
		//q_state_input_sram_write_enable_r = 0;
		inst_rnd = 100;  	
	end
  end

 

  always @(*) begin
	casex (current_state)
		s0 : begin
		  if (dut_valid == 1'b0) begin
			
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;

			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_counter5 = 2'b0;
			val_counter7 = 2'b0;
			write = 128'b1;
			dut_ready = 1'b1;
			Q_size_var = 2'b0;
		  	q_state_input_sram_read_address_var = 2'b0;
			q_gates_sram_read_address_var = 2'b0;
		  	scratchpad_sram_read_address_var = 2'b0;
			scratchpad_sram_write_address_var = 2'b0;
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;
			val_counter = 128'b0;
			val_scratchpad_sram_write_data = 2'b0;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_input_sram_write_data = 2'b0;
			q_state_input_sram_write_enable_r = 1'b0;
			val_q_state_output_sram_write_data = 1'b0;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s0;
		  end
		  else begin
			
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;
			write = 128'b1;
			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_counter5 = 2'b0;
			val_counter7 = 2'b0;

			dut_ready = 1'b0;
			Q_size_var = 2'b0;
		  	q_state_input_sram_read_address_var = 2'b0;
			q_gates_sram_read_address_var = 2'b0;
		  	scratchpad_sram_read_address_var = 2'b0;
			scratchpad_sram_write_address_var = 2'b0;
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;
			val_counter = 128'b0;
			val_scratchpad_sram_write_data = 2'b0;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_input_sram_write_data = 2'b0;
			q_state_input_sram_write_enable_r = 1'b0;
			val_q_state_output_sram_write_data = 1'b0;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s1;
		  end		
		end
		s1 : begin         
			

			write = 128'b1;
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;

			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_counter5 = 2'b0;
			val_counter7 = 2'b10;

			dut_ready = 1'b0;
			Q_size_var = 2'b01;
		  	q_state_input_sram_read_address_var = 2'b0;  //0
			q_gates_sram_read_address_var = 2'b0;
		  	scratchpad_sram_read_address_var = 2'b0;
			scratchpad_sram_write_address_var = 2'b10;
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;

			val_scratchpad_sram_write_data = 2'b0;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_input_sram_write_data = 2'b0;
			q_state_input_sram_write_enable_r = 1'b0;
			val_q_state_output_sram_write_data = 1'b0;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s8;
		end
		s8 : begin         
			

			write = 128'b1;
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;

			val_counter = 2'b01;
			val_counter1 = 2'b1;
			val_counter2 = 2'b1;
			val_counter5 = 2'b0;
			val_counter7 = 2'b10;

			dut_ready = 1'b0;
			Q_size_var = 2'b10;
		  	q_state_input_sram_read_address_var = 2'b01;  //0
			q_gates_sram_read_address_var = 2'b10;
		  	scratchpad_sram_read_address_var = 2'b0;
			scratchpad_sram_write_address_var = 2'b0;
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;

			val_scratchpad_sram_write_data = 2'b0;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_input_sram_write_data = 2'b0;
			q_state_input_sram_write_enable_r = 1'b0;
			val_q_state_output_sram_write_data = 1'b0;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s2;
		end
		s2 : begin
			val_counter = 2'b1;
			val_counter7 = 2'b10;

			if(counter_0 <= 128'b10) begin
				counter_3 = 128'b0;
			end
			else begin
				counter_3 = counter_3 + 128'b1;
			end

			if(counter_0 <= 128'b11) begin
				counter_4 = 128'b0;
			end
			else begin
				counter_4 = counter_4 + 128'b1;
			end

			if(counter_0 <= 128'b100) begin
				//counter_5 = 128'b0;
				counter_6 = 128'b0;
			end
			else if(counter_0 > 128'b100) begin
				//counter_5 = counter_5 + 128'b1;
				counter_6 = counter_6 + 128'b1;
			end

			



			if(counter_0 < 128'b10) begin
				val_inst = 2'b0;
			end
			else if(counter_0 == 128'b10) begin
				val_inst = 2'b1;
			end
			else if(counter_0 > 128'b10 && (counter_3 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_inst = 2'b0;
			end
			else if(counter_0 > 128'b10 && (counter_3 < 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_inst = 2'b1;
			end
			
			if(counter_0 < 128'b11) begin
				val_add = 1'b0;
			end
			else if(counter_0 == 128'b11) begin
				val_add = 1'b1;
			end
			else if(counter_0 > 128'b11 && (counter_4 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_add = 1'b0;
			end
			else if(counter_0 > 128'b11 && (counter_4 < 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_add = 1'b1;
			end

			if(counter_0 < 128'b100) begin
				val_counter5 = 2'b0;
				val_add_3 = 2'b0;
			end
			else if(counter_0 == 128'b100) begin
				val_counter5 = 2'b1;				
				val_add_3 = 2'b1;
			end
			else if(counter_0 > 128'b100 && (counter_6 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_counter5 = 2'b11;
				val_add_3 = 2'b0;
			end
			else if(counter_0 > 128'b100 && (counter_5 == 128'b10 << (Q_size - 64'b1))) begin
				val_counter5 = 2'b11;
				val_add_3 = 2'b10;
			end
			else if(counter_0 > 128'b100) begin
				val_counter5 = 2'b1;
				val_add_3 = 2'b1;
				
			end

			if(counter_0 < 128'b100) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_output_sram_write_address_var = 2'b0;
				scratchpad_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;
			end
			else if(counter_0 == 128'b100) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_output_sram_write_address_var = 2'b0;
				scratchpad_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;		
			end
			else if(counter_0 > 128'b101 && counter_5 == 128'b1) begin
				scratchpad_sram_write_address_var = 2'b1;
				q_state_output_sram_write_address_var = 2'b1;
				scratchpad_sram_write_enable_r = 1'b1;
				q_state_output_sram_write_enable_r = 1'b1;		
			end
			else if(counter_0 > 128'b100 && counter_5 > 128'b0) begin
				scratchpad_sram_write_address_var = 2'b10;
				q_state_output_sram_write_address_var = 2'b10;
				scratchpad_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;		
			end



			dut_ready = 1'b0;
			Q_size_var = 2'b10;
			if (counter_1 == 128'b10 << (Q_size - 64'b1)) begin
				q_state_input_sram_read_address_var = 2'b11; //2
				val_counter1 = 2'b11;
			end
			else if (counter_1 != 128'b10 << (Q_size - 64'b1)) begin 
				q_state_input_sram_read_address_var = 2'b01;  //1
				val_counter1 = 2'b1;
			end			

		  	if(counter_2 == 128'b10 << (Q_size + Q_size - 64'b1)) begin
				q_gates_sram_read_address_var = 2'b10;  //4
				val_counter2 = 2'b10;
			end
			else begin
				q_gates_sram_read_address_var = 2'b01;    //0
				val_counter2 = 2'b1;
			end
			
			q_state_input_sram_write_enable_r = 1'b0;

		  	scratchpad_sram_read_address_var = 2'b0;
			q_state_input_sram_write_address_var = 2'b11;
			val_scratchpad_sram_write_data = 2'b1;

			val_q_state_input_sram_write_data = 2'b0;

			val_q_state_output_sram_write_data = 1'b1;

			if(counter_6 == 128'b10 << (Q_size + Q_size - 64'b1)) 
				next_state = s3;
			else
				next_state = s2;
			
		end
		s3 : begin  
			
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;

			q_state_input_sram_write_enable_r = 1'b0;
			
			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_counter5 = 2'b0;

			dut_ready = 1'b0;
			Q_size_var = 2'b10;
		  	q_state_input_sram_read_address_var = 2'b11;  //2
			q_gates_sram_read_address_var = 2'b10;        //0

		  	scratchpad_sram_read_address_var = 2'b0;    //0
			scratchpad_sram_write_address_var = 2'b0;    //0
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;

			val_scratchpad_sram_write_data = 2'b1;
			scratchpad_sram_write_enable_r = 1'b1;
			val_q_state_input_sram_write_data = 2'b0;
			val_q_state_output_sram_write_data = 1'b1;
			q_state_output_sram_write_enable_r = 1'b1;

			if(counter_7 == (M_size - 64'b1)) begin
				val_counter7 = 2'b10;
				next_state = s0;
			end
			else if(counter_7 != (M_size - 64'b1)) begin
				val_counter7 = 2'b1;
				next_state = s4;
			end	
		end
		s4 : begin  
			
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;

			val_counter7 = 2'b10;


			
			val_counter = 2'b1;
			val_counter1 = 2'b1;
			val_counter2 = 2'b1;
			val_counter5 = 2'b0;

			dut_ready = 1'b0;
			Q_size_var = 2'b10;
		  	q_state_input_sram_read_address_var = 2'b11;  //2
			q_gates_sram_read_address_var = 2'b1;        //0

		  	scratchpad_sram_read_address_var = 2'b0;    //0
			scratchpad_sram_write_address_var = 2'b0;    //0
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;

			val_scratchpad_sram_write_data = 2'b1;
			scratchpad_sram_write_enable_r = 1'b0;

			val_q_state_input_sram_write_data = 2'b1;
			q_state_input_sram_write_enable_r = 1'b0;

			val_q_state_output_sram_write_data = 1'b1;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s5;
		end

		s5 : begin
			val_counter = 2'b1;
			val_counter7 = 2'b10;

			if(counter_0 <= 128'b10) begin
				counter_3 = 128'b0;
			end
			else begin
				counter_3 = counter_3 + 128'b1;
			end

			if(counter_0 <= 128'b11) begin
				counter_4 = 128'b0;
			end
			else begin
				counter_4 = counter_4 + 128'b1;
			end

			if(counter_0 <= 128'b100) begin
				//counter_5 = 128'b0;
				counter_6 = 128'b0;
			end
			else if(counter_0 > 128'b100) begin
				//counter_5 = counter_5 + 128'b1;
				counter_6 = counter_6 + 128'b1;
			end

			



			if(counter_0 < 128'b10) begin
				val_inst = 2'b0;
			end
			else if(counter_0 == 128'b10) begin
				val_inst = 2'b10;
			end
			else if(counter_0 > 128'b10 && (counter_3 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_inst = 2'b0;
			end
			else if(counter_0 > 128'b10 && (counter_3 < 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_inst = 2'b10;
			end
			
			if(counter_0 < 128'b11) begin
				val_add = 1'b0;
			end
			else if(counter_0 == 128'b11) begin
				val_add = 1'b1;
			end
			else if(counter_0 > 128'b11 && (counter_4 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_add = 1'b0;
			end
			else if(counter_0 > 128'b11 && (counter_4 < 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_add = 1'b1;
			end

			if(counter_0 < 128'b100) begin
				val_counter5 = 2'b0;
				val_add_3 = 2'b0;
			end
			else if(counter_0 == 128'b100) begin
				val_counter5 = 2'b1;				
				val_add_3 = 2'b1;
			end
			else if(counter_0 > 128'b100 && (counter_6 >= 128'b10 << (Q_size + Q_size - 64'b1))) begin
				val_counter5 = 2'b11;
				val_add_3 = 2'b0;
			end
			else if(counter_0 > 128'b100 && (counter_5 == 128'b10 << (Q_size - 64'b1))) begin
				val_counter5 = 2'b11;
				val_add_3 = 2'b10;
			end
			else if(counter_0 > 128'b100) begin
				val_counter5 = 2'b1;
				val_add_3 = 2'b1;
				
			end

			if(counter_0 < 128'b100) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_input_sram_write_address_var = 2'b10;
				q_state_output_sram_write_address_var = 2'b0;
				q_state_input_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;
			end
			else if(counter_0 == 128'b100) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_input_sram_write_address_var = 2'b10;
				q_state_output_sram_write_address_var = 2'b0;
				q_state_input_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;		
			end
			else if(counter_0 > 128'b101 && counter_5 == 128'b1) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_input_sram_write_address_var = 2'b1;
				q_state_output_sram_write_address_var = 2'b1;
				q_state_input_sram_write_enable_r = 1'b1;
				q_state_output_sram_write_enable_r = 1'b1;		
			end
			else if(counter_0 > 128'b100 && counter_5 > 128'b0) begin
				scratchpad_sram_write_address_var = 2'b0;
				q_state_input_sram_write_address_var = 2'b10;
				q_state_output_sram_write_address_var = 2'b10;
				q_state_input_sram_write_enable_r = 1'b0;
				q_state_output_sram_write_enable_r = 1'b0;		
			end

			scratchpad_sram_write_enable_r = 1'b0;

			dut_ready = 1'b0;
			Q_size_var = 2'b10;
			if (counter_1 == 128'b10 << (Q_size - 64'b1)) begin
				//q_state_input_sram_read_address_var = 2'b11; //2
				scratchpad_sram_read_address_var = 2'b0;
				val_counter1 = 2'b11;
			end
			else if (counter_1 != 128'b10 << (Q_size - 64'b1)) begin 
				//q_state_input_sram_read_address_var = 2'b01;  //1
				scratchpad_sram_read_address_var = 2'b1;
				val_counter1 = 2'b1;
			end			

		  	if(counter_2 == 128'b10 << (Q_size + Q_size - 64'b1)) begin
				q_gates_sram_read_address_var = 2'b10;  //4
				val_counter2 = 2'b10;
			end
			else begin
				q_gates_sram_read_address_var = 2'b01;    //0
				val_counter2 = 2'b1;
			end
			
			q_state_input_sram_read_address_var = 2'b11;
		  	//scratchpad_sram_read_address_var = 2'b0;

			val_scratchpad_sram_write_data = 2'b0;

			val_q_state_input_sram_write_data = 2'b1;

			val_q_state_output_sram_write_data = 1'b1;

			if(counter_6 == 128'b10 << (Q_size + Q_size - 64'b1)) 
				next_state = s6;
			else
				next_state = s5;
			
		end
		s6 : begin  
			
			counter_3 = 128'b0;
			counter_4 = 128'b0;
			//counter_5 = 128'b0;
			counter_6 = 128'b0;


			
			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_counter5 = 2'b0;

			dut_ready = 1'b0;
			Q_size_var = 2'b10;
		  	q_state_input_sram_read_address_var = 2'b0;  //2
			q_gates_sram_read_address_var = 2'b1;        //0

		  	scratchpad_sram_read_address_var = 2'b0;    //0
			scratchpad_sram_write_address_var = 2'b0;    //0
			q_state_input_sram_write_address_var = 2'b11;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;

			val_scratchpad_sram_write_data = 2'b1;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_input_sram_write_data = 2'b1;
			q_state_input_sram_write_enable_r = 1'b1;
			val_q_state_output_sram_write_data = 1'b1;
			q_state_output_sram_write_enable_r = 1'b1;

			if(counter_7 == (M_size - 64'b1)) begin
				val_counter7 = 2'b10;
				next_state = s0;
			end
			else if(counter_7 < (M_size - 64'b1)) begin
				val_counter7 = 2'b1;
				next_state = s8;
			end	
		end

		
		default : begin

			dut_ready = 1'b1;
			Q_size_var = 2'b0;
		  	q_state_input_sram_read_address_var = 2'b0;
			q_gates_sram_read_address_var = 2'b0;
		  	scratchpad_sram_read_address_var = 2'b0;
			scratchpad_sram_write_address_var = 2'b0;
			q_state_output_sram_write_address_var = 2'b0;
			val_inst = 2'b0;
			val_add = 1'b0;
			val_add_3 = 1'b0;
			val_counter = 2'b0;
			val_counter1 = 2'b0;
			val_counter2 = 2'b0;
			val_scratchpad_sram_write_data = 2'b0;
			scratchpad_sram_write_enable_r = 1'b0;
			val_q_state_output_sram_write_data = 1'b0;
			q_state_output_sram_write_enable_r = 1'b0;
			next_state = s0;	
		end			
	endcase
  end

  always @(posedge clk) begin  //Q_size_var
		if (Q_size_var == 2'b0) begin
			Q_size <= 64'b0;
			M_size <= 64'b0;
		end
		else if (Q_size_var == 2'b01) begin
			Q_size <= q_state_input_sram_read_data[127:64];
			M_size <= q_state_input_sram_read_data[63:0];
		end
		else if (Q_size_var == 2'b10) begin
			Q_size <= Q_size;
			M_size <= M_size;
		end
  end

  always @(posedge clk) begin   // q_state_input_sram_read_address_var
		if (q_state_input_sram_read_address_var == 2'b0)
			q_state_input_sram_read_address_r <= 32'b0;
		else if (q_state_input_sram_read_address_var == 2'b01)
			q_state_input_sram_read_address_r <= q_state_input_sram_read_address_r + 32'b1;
		else if (q_state_input_sram_read_address_var == 2'b10)
			q_state_input_sram_read_address_r <= q_state_input_sram_read_address_r;
		else if (q_state_input_sram_read_address_var == 2'b11)
			  q_state_input_sram_read_address_r <= 32'b1;	
  end

  assign q_state_input_sram_read_address = q_state_input_sram_read_address_r;

  always @(posedge clk) begin     // q_gates_sram_read_address_var
		if (q_gates_sram_read_address_var == 2'b0)
			q_gates_sram_read_address_r <= 32'b0;
		else if (q_gates_sram_read_address_var == 2'b01)
			q_gates_sram_read_address_r <= q_gates_sram_read_address_r + 32'b1;
		else if (q_gates_sram_read_address_var == 2'b10)
			q_gates_sram_read_address_r <= q_gates_sram_read_address_r;
		else if (q_gates_sram_read_address_var == 2'b11)
			q_gates_sram_read_address_r <= 32'b1;	
  end

  assign q_gates_sram_read_address = q_gates_sram_read_address_r;

  always @(posedge clk) begin      // scratchpad_sram_read_address_var 
		if (scratchpad_sram_read_address_var == 2'b0)
			scratchpad_sram_read_address_r <= 32'b0;
		else if (scratchpad_sram_read_address_var == 2'b01)
			scratchpad_sram_read_address_r <= scratchpad_sram_read_address_r + 32'b1;
		else if (scratchpad_sram_read_address_var == 2'b10)
			scratchpad_sram_read_address_r <= scratchpad_sram_read_address_r;
		else if (scratchpad_sram_read_address_var == 2'b11)
			scratchpad_sram_read_address_r <= 32'b1;	
  end

 assign scratchpad_sram_read_address = scratchpad_sram_read_address_r;

  always @(posedge clk) begin      // scratchpad_sram_write_address_var 
		if (scratchpad_sram_write_address_var == 2'b0)
			scratchpad_sram_write_address_r <= 32'b0;
		else if (scratchpad_sram_write_address_var == 2'b01)
			scratchpad_sram_write_address_r <= scratchpad_sram_write_address_r + 32'b1;
		else if (scratchpad_sram_write_address_var == 2'b10)
			scratchpad_sram_write_address_r <= scratchpad_sram_write_address_r;
		else if (scratchpad_sram_write_address_var == 2'b11)
			scratchpad_sram_write_address_r <= 32'b11;	
  end

  assign scratchpad_sram_write_address = scratchpad_sram_write_address_r;

  always @(posedge clk) begin      // q_state_input_sram_write_address_var 
		if (q_state_input_sram_write_address_var == 2'b0)
			q_state_input_sram_write_address_r <= 32'b0;
		else if (q_state_input_sram_write_address_var == 2'b01)
			q_state_input_sram_write_address_r <= q_state_input_sram_write_address_r + 32'b1;
		else if (q_state_input_sram_write_address_var == 2'b10)
			q_state_input_sram_write_address_r <= q_state_input_sram_write_address_r;
		else if (q_state_input_sram_write_address_var == 2'b11)
			q_state_input_sram_write_address_r <= 32'b1;	
  end

  assign q_state_input_sram_write_address = q_state_input_sram_write_address_r;

  always @(posedge clk) begin      // q_state_output_sram_write_address_var 
		if (q_state_output_sram_write_address_var == 2'b0)
			q_state_output_sram_write_address_r <= 32'b0;
		else if (q_state_output_sram_write_address_var == 2'b01)
			q_state_output_sram_write_address_r <= q_state_output_sram_write_address_r + 32'b1;
		else if (q_state_output_sram_write_address_var == 2'b10)
			q_state_output_sram_write_address_r <= q_state_output_sram_write_address_r;
		else if (q_state_output_sram_write_address_var == 2'b11)
			q_state_output_sram_write_address_r <= 32'b1;	
  end

  assign q_state_output_sram_write_address = q_state_output_sram_write_address_r;

	assign q_state_output_sram_write_enable = q_state_output_sram_write_enable_r;
	assign q_state_input_sram_write_enable = q_state_input_sram_write_enable_r;
	assign scratchpad_sram_write_enable = scratchpad_sram_write_enable_r;

  always @(posedge clk) begin  //val_inst
		if (val_inst == 2'b0) begin
			inst_a <= 64'b0;
			inst_b <= 64'b0;
			inst_c <= 64'b0;
			inst_d <= 64'b0;
    end
		else if (val_inst == 2'b01) begin
      inst_a <= q_state_input_sram_read_data[127:64];
      inst_b <= q_state_input_sram_read_data[63:0];
      inst_c <= q_gates_sram_read_data[127:64];
      inst_d <= q_gates_sram_read_data[63:0];
		end
    else if (val_inst == 2'b10) begin
      inst_a <= scratchpad_sram_read_data[127:64];
      inst_b <= scratchpad_sram_read_data[63:0];
			inst_c <= q_gates_sram_read_data[127:64];
			inst_d <= q_gates_sram_read_data[63:0];
    end
  end

  always @(posedge clk) begin  //val_add
		if (val_add == 1'b0) begin
		        a_a1 <= 64'b0;
		        a_b1 <= 64'b0;
		        a_a2 <= 64'b0;
		        a_b2 <= 64'b0;
		end
		else if (val_add == 1'b1) begin
		        a_a1 <= inst_1;
		        a_b1 <= inst_2; 
		        a_a2 <= {~inst_3[63], inst_3[62:0]};
		        a_b2 <= inst_4;
		end
  end

  always @(posedge clk) begin  //val_add_3
		if (val_add_3 == 2'b0) begin
		        a_a3 <= 64'b0;
		        a_b3 <= 64'b0;
		        a_a4 <= 64'b0;
		        a_b4 <= 64'b0;
		end
		else if (val_add_3== 2'b01) begin
		        a_a3 <= a_z1;
		        a_b3 <= a_z3;
		        a_a4 <= a_z2;
		        a_b4 <= a_z4;
		end		
		else if (val_add_3== 2'b10) begin
		        a_a3 <= a_z1;
		        a_b3 <= 64'b0;
		        a_a4 <= a_z2;
		         a_b4 <= 64'b0;
		end
  end


    always @(posedge clk) begin
		if (val_counter == 2'b0) begin
			counter_0 <= 128'b0;
			//counter_1 <= 128'b0;
			//counter_2 <= 128'b0;
		end
		else if (val_counter == 2'b01) begin
			counter_0 <= counter_0 + 128'b1;
			//counter_1 <= counter_1 + 128'b1;
			//counter_2 <= counter_2 + 128'b1;
		end
		else if (val_counter == 2'b10) begin
			counter_0 <= counter_0;
			//counter_1 <= counter_1;
			//counter_2 <= counter_2;
		end
    end

    always @(posedge clk) begin
		if (val_counter1 == 2'b0) begin
			counter_1 <= 128'b0;
		end
		else if (val_counter1 == 2'b01) begin
			counter_1 <= counter_1 + 128'b1;
		end
		else if (val_counter1 == 2'b10) begin
			counter_1 <= counter_1;
		end
		else if (val_counter1 == 2'b11) begin
			counter_1 <= 128'b1;
		end
    end

    always @(posedge clk) begin
		if (val_counter2 == 2'b0) begin
			counter_2 <= 128'b0;
		end
		else if (val_counter2 == 2'b01) begin
			counter_2 <= counter_2 + 128'b1;
		end
		else if (val_counter2 == 2'b10) begin
			counter_2 <= counter_2;
		end
		else if (val_counter2 == 2'b11) begin
			counter_2 <= 128'b1;
		end
    end

    always @(posedge clk) begin
		if (val_counter5 == 2'b0) begin
			counter_5 <= 128'b0;
		end
		else if (val_counter5 == 2'b01) begin
			counter_5 <= counter_5 + 128'b1;
		end
		else if (val_counter5 == 2'b10) begin
			counter_5 <= counter_5;
		end
		else if (val_counter5 == 2'b11) begin
			counter_5 <= 128'b1;
		end
    end

	always @(posedge clk) begin
		if (val_counter7 == 2'b0) begin
			counter_7 <= 128'b0;
		end
		else if (val_counter7 == 2'b01) begin
			counter_7 <= counter_7 + 128'b1;
		end
		else if (val_counter7 == 2'b10) begin
			counter_7 <= counter_7;
		end
		else if (val_counter7 == 2'b11) begin
			counter_7 <= 128'b10;
		end
    end

  always @(posedge clk) begin
		if (val_scratchpad_sram_write_data == 2'b0)
			scratchpad_sram_write_data_r = 128'b0;
		else if (val_scratchpad_sram_write_data == 2'b01)
			scratchpad_sram_write_data_r = {a_z4,a_z3}; 
		else if (val_scratchpad_sram_write_data == 2'b10)    
			scratchpad_sram_write_data_r = scratchpad_sram_write_data_r;
  end

  assign scratchpad_sram_write_data = scratchpad_sram_write_data_r;

  always @(posedge clk) begin
		if (val_q_state_input_sram_write_data == 2'b0)
			q_state_input_sram_write_data_r = 128'b0;
		else if (val_q_state_input_sram_write_data == 2'b01)
			q_state_input_sram_write_data_r = {a_z4,a_z3}; 
		else if (val_q_state_input_sram_write_data == 2'b10)    
			q_state_input_sram_write_data_r = q_state_input_sram_write_data_r;
  end

  assign q_state_input_sram_write_data = q_state_input_sram_write_data_r;

  always @(posedge clk) begin
		if (val_q_state_output_sram_write_data == 1'b0)
			q_state_output_sram_write_data_r <= 128'b0;
		else if (val_q_state_output_sram_write_data == 1'b1)
			q_state_output_sram_write_data_r <= {a_z4,a_z3};
  end

  assign q_state_output_sram_write_data = q_state_output_sram_write_data_r;
  

	assign q_gates_sram_write_enable = 1'b0;
	assign q_gates_sram_write_address = 1'b0;
	assign q_gates_sram_write_data = 1'b0;
	assign q_state_output_sram_read_address = 1'b0;


  /*DW_fp_add_inst_alter FP_A_ADD1 ( 
    a_a1,
    a_b1,
    a_z1,
    inst_rnd,
    status_inst
  );

  DW_fp_add_inst_alter FP_A_ADD2 ( 
    a_a2,
    a_b2,
    a_z2,
    inst_rnd,
    status_inst
  );

  DW_fp_add_inst_alter FP_A_ADD3 #(104, 22, 3) ( 
    a_a5,  // a_z1 + a_z2
    a_b5,  // a_z5
    a_z5,
    inst_rnd,
    status_inst
  );*/

  // This is test stub for passing input/outputs to a DP_fp_mac, there many
  // more DW macros that you can choose to use
  /*DW_fp_mult_inst FP_MULT1 ( 
    inst_a,
    inst_b,
    inst_c,
    inst_d,
    inst_1,
    inst_2,
    inst_3,
    inst_4,
    inst_rnd,
    status_inst
  );

  DW_fp_add_inst FP_ADD1 ( 
    a_a1,
    a_b1,
    a_a2,
    a_b2,
    a_a3,
    a_b3,
    a_a4,
    a_b4,
    a_z1,
    a_z2,
    a_z3,
    a_z4,
    inst_rnd,
    status_inst
  );*/

  `define inst_sig_width = 52,
  `define inst_exp_width = 11,
  `define inst_ieee_compliance = 3 

  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U1 (  //4
    .a(inst_c), //real gate
    .b(inst_b), //image input
    .rnd(inst_rnd),
    .z(inst_1),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U2 (  //3
    .a(inst_a), //real input
    .b(inst_d), //image gate
    .rnd(inst_rnd),
    .z(inst_2),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U3 (  //2
    .a(inst_d), //image gate
    .b(inst_b), //image input
    .rnd(inst_rnd),
    .z(inst_3),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U4 ( //1
    .a(inst_a), //real input
    .b(inst_c), //real gate
    .rnd(inst_rnd),
    .z(inst_4),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U5 (
    .a(a_a1),
    .b(a_b1),
    .rnd(inst_rnd),
    .z(a_z1),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U6 (
    .a(a_a2),
    .b(a_b2),
    .rnd(inst_rnd),
    .z(a_z2),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U7 (
    .a(a_a3),
    .b(a_b3),
    .rnd(inst_rnd),
    .z(a_z3),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U8 (
    .a(a_a4),
    .b(a_b4),
    .rnd(inst_rnd),
    .z(a_z4),
    .status(status_inst) 
  );

endmodule


module DW_fp_mult_inst #(
  parameter inst_sig_width = 52,
  parameter inst_exp_width = 11,
  parameter inst_ieee_compliance = 3 // These need to be fixed to decrease error
) ( 
  input wire [inst_sig_width+inst_exp_width : 0] inst_a, //real input
  input wire [inst_sig_width+inst_exp_width : 0] inst_b, //image input
  input wire [inst_sig_width+inst_exp_width : 0] inst_c, //real gate
  input wire [inst_sig_width+inst_exp_width : 0] inst_d, //image gate
  output wire [inst_sig_width+inst_exp_width : 0] inst_1, // out1
  output wire [inst_sig_width+inst_exp_width : 0] inst_2, // out2
  output wire [inst_sig_width+inst_exp_width : 0] inst_3, // out3
  output wire [inst_sig_width+inst_exp_width : 0] inst_4, // out4
  input wire [2 : 0] inst_rnd,
  output wire [7 : 0] status_inst
);

  // Instance of DW_fp_mult
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U1 (
    .a(inst_c), //real gate
    .b(inst_b), //image input
    .rnd(inst_rnd),
    .z(inst_1),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U2 (
    .a(inst_a), //real input
    .b(inst_d), //image gate
    .rnd(inst_rnd),
    .z(inst_2),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U3 (
    .a(inst_d), //image gate
    .b(inst_b), //image input
    .rnd(inst_rnd),
    .z(inst_3),
    .status(status_inst) 
  );
  DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U4 (
    .a(inst_a), //real input
    .b(inst_c), //real gate
    .rnd(inst_rnd),
    .z(inst_4),
    .status(status_inst) 
  );



endmodule

module DW_fp_add_inst #(
  parameter inst_sig_width = 52,
  parameter inst_exp_width = 11,
  parameter inst_ieee_compliance = 3 // These need to be fixed to decrease error
) ( 
  input wire [inst_sig_width+inst_exp_width : 0] a_a1, //inst_1 
  input wire [inst_sig_width+inst_exp_width : 0] a_b1, //inst_2 
  input wire [inst_sig_width+inst_exp_width : 0] a_a2, //inst_3 
  input wire [inst_sig_width+inst_exp_width : 0] a_b2, //inst_4
  input wire [inst_sig_width+inst_exp_width : 0] a_a3, //a_z1
  input wire [inst_sig_width+inst_exp_width : 0] a_b3, //a_z3
  input wire [inst_sig_width+inst_exp_width : 0] a_a4, //a_z2
  input wire [inst_sig_width+inst_exp_width : 0] a_b4, //a_z4
  output wire [inst_sig_width+inst_exp_width : 0] a_z1, // out1
  output wire [inst_sig_width+inst_exp_width : 0] a_z2, // out2
  output wire [inst_sig_width+inst_exp_width : 0] a_z3, // out3
  output wire [inst_sig_width+inst_exp_width : 0] a_z4, // out4
  input wire [2 : 0] inst_rnd,
  output wire [7 : 0] status_inst
);

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U1 (
    .a(a_a1),
    .b(a_b1),
    .rnd(inst_rnd),
    .z(a_z1),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U2 (
    .a(a_a2),
    .b(a_b3),
    .rnd(inst_rnd),
    .z(a_z2),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U3 (
    .a(a_a3),
    .b(a_b3),
    .rnd(inst_rnd),
    .z(a_z3),
    .status(status_inst) 
  );

  DW_fp_add #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U4 (
    .a(a_a4),
    .b(a_b4),
    .rnd(inst_rnd),
    .z(a_z4),
    .status(status_inst) 
  );
endmodule
module DW_fp_mac_inst #(
  parameter inst_sig_width = 52,
  parameter inst_exp_width = 11,
  parameter inst_ieee_compliance = 3 // These need to be fixed to decrease error
) ( 
  input wire [inst_sig_width+inst_exp_width : 0] inst_a,
  input wire [inst_sig_width+inst_exp_width : 0] inst_b,
  input wire [inst_sig_width+inst_exp_width : 0] inst_c,
  input wire [2 : 0] inst_rnd,
  output wire [inst_sig_width+inst_exp_width : 0] z_inst,
  output wire [7 : 0] status_inst
);

  // Instance of DW_fp_mac
  DW_fp_mac #(inst_sig_width, inst_exp_width, inst_ieee_compliance) U1 (
    .a(inst_a),
    .b(inst_b),
    .c(inst_c),
    .rnd(inst_rnd),
    .z(z_inst),
    .status(status_inst) 
  );

endmodule