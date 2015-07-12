--����bufferʵ�ֵķ�Ƶ����������������CNT10����
LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
ENTITY FrequencyDivider is 
PORT(
	data: in std_logic_vector(15 downto 0);--16λԤ������load�Ǹߵ�ƽ����
	en,clk:in std_logic;--ʹ�ܣ�ʱ��
	q: buffer std_logic_vector(15 downto 0);--16λ����
	cout:buffer std_logic--���λ���ߵ�ƽ�������buffer����״̬ȡ��������ʵ�ַ�Ƶ
);
END FrequencyDivider;

architecture behavior OF FrequencyDivider IS 

BEGIN
	process(clk,en,cout) begin
		if(rising_edge(clk)) then --ʱ��������ʱ��ʼ����
			 if(en='1')then --Enable������
				if(q=data-1)then --qΪdata�����ʵ�ַ�Ƶ����Ϊ��0��ʼ������Ҫ��1
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

--�ֲӱ�
--https://github.com/lincanbin
--20150504