
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_uart_parallel IS
END tb_uart_parallel;
 
ARCHITECTURE behavior OF tb_uart_parallel IS 
 
 
    COMPONENT UART_PARALLEL
    PORT(
         clk : IN  std_logic;
         nrst : IN  std_logic;
         start : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         data_ready : OUT  std_logic;
         tx : OUT  std_logic;
         rx : IN  std_logic;
         buad : IN  std_logic_vector(7 downto 0);
			aclk_out:out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal nrst : std_logic := '0';
   signal start : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal rx : std_logic := '0';
   signal buad : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);
   signal data_ready : std_logic;
   signal tx : std_logic;
   signal aclk_out : std_logic;
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_PARALLEL PORT MAP (
          clk => clk,
          nrst => nrst,
          start => start,
          data_in => data_in,
          data_out => data_out,
          data_ready => data_ready,
          tx => tx,
          rx => rx,
          buad => buad,
			 aclk_out =>aclk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		nrst<='0';
		rx<='1';
		buad<=x"01";
      wait for clk_period*20;
		nrst<='1';
		start<='1';
		data_in<="11010001";
		wait for clk_period*2;
		start<='0';
		wait for clk_period*40;		
		rx<='0';	
		wait for clk_period*2;		
		rx<='1';	
		wait for clk_period*2;	
		rx<='0';	 
		wait for clk_period*2;	
		rx<='1';	
		wait for clk_period*2;	
		rx<='1';	
		wait for clk_period*2;	
		rx<='1';	
		wait for clk_period*2;	
		rx<='0';	
		wait for clk_period*2;	
		rx<='0';	
		wait for clk_period*2;	
		rx<='1';	
		wait for clk_period*2;	
		rx<='1';	
      wait;
   end process;

END;
