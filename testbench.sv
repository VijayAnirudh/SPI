module spi_test();

	parameter bits = 8;

	reg sys_clk;
	reg t_start;
	reg [bits-1:0] d_in;
	wire [bits-1:0] d_out;
	reg [$clog2(bits):0] t_size;
	wire cs;
	reg rstn;
	wire spi_clk;
	wire miso;
	wire mosi;

	simple_spi_m_bit_rw
	#(
		.reg_width(bits)
	) spi
	(
		.sys_clk(sys_clk),
		.t_start(t_start),
		.d_in(d_in),
		.d_out(d_out),
		.t_size(t_size),
		.cs(cs),
		.rstn(rstn),
		.spi_clk(spi_clk),
		.miso(miso),
		.mosi(mosi)
	);

	assign miso = mosi;
	always
		#2 sys_clk = !sys_clk;

	initial
	begin
		sys_clk = 0;
		t_start = 0;
		d_in = 0;
		rstn = 0;
		t_size = bits;
		#4;
		rstn = 1;
	end

	initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(0,spi_test);
	end

	initial begin
      #8 t_start = 1;
      
      d_in = 8'haa;
      
      #10 t_start = 0;
      
      #180 $finish;
    end

endmodule
