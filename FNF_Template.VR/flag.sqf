flagObj attachTo [player, [0.1,0.4,1.45], "aiming_axis"];
switch (side player) do {
	case east: {
		flagObj setFlagTexture "\A3\Data_F\Flags\flag_red_co.paa"; 
	};
	case west: {
		flagObj setFlagTexture "\A3\Data_F\Flags\flag_blue_co.paa"; 
	};
};