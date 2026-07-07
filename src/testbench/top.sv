module top( );

    import ram_pkg ::*;
    bit clk;
    bit reset;


  initial
    begin
     forever #10 clk=~clk;
    end

  initial
    begin
      @(posedge clk);
      reset=0;
      repeat(5)@(posedge clk);
      reset=1;
     repeat(40)@(posedge clk);
      reset=0;
     repeat(10)@(posedge clk);
       reset=1;
    end

    ram_if intrf(clk,reset);
    RAM DUV(.data_in(intrf.data_in),
            .write_enb(intrf.write_enb),
            .read_enb(intrf.read_enb),
            .data_out(intrf.data_out),
            .address(intrf.address),
            .clk(clk),
            .reset(reset)
           );
    ram_test tb;
    test1 tb1;
    test2 tb2;
    test3 tb3;
    test4 tb4;
    test_regression tb_regression;

   initial begin
    tb= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    tb1= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    tb2= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    tb3= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    tb4=new(intrf.DRV,intrf.MON,intrf.REF_SB);
     tb_regression= new(intrf.DRV,intrf.MON,intrf.REF_SB);
   end
  initial
   begin
    tb_regression.run();
    tb.run();
    tb1.run();
    tb2.run();
    tb3.run();
    tb4.run();
    $finish();
   end
endmodule


