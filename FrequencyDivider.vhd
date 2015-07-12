--利用buffer实现的分频器，代码量少于用CNT10改造
LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
ENTITY FrequencyDivider is 
PORT(
	data: in std_logic_vector(15 downto 0);--16位预置数，load非高电平置数
	en,clk:in std_logic;--使能，时钟
	q: buffer std_logic_vector(15 downto 0);--16位计数
	cout:buffer std_logic--溢出位，高电平溢出，用buffer保存状态取反，轻易实现分频
);
END FrequencyDivider;

architecture behavior OF FrequencyDivider IS 

BEGIN
	process(clk,en,cout) begin
		if(rising_edge(clk)) then --时钟上升沿时开始工作
			 if(en='1')then --Enable，开关
				if(q=data-1)then --q为data，溢出实现分频，因为从0开始加所以要减1
					q<="0000000000000000";
					if(cout='1') then
						cout<='0';
					else
						cout<='1';
					end if;
				else
					q<=q+1; 
				end if;
			else
				q<=q;
			end if; 
		end if;
	end process;
END behavior;

--林灿斌
--https://github.com/lincanbin
--20150504