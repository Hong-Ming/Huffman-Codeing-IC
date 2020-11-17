`timescale 1ns/10ps
module PATTERN(
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
//================================================================
// wire & registers
//================================================================
output logic  clk;
output logic  rst_n;
output logic  in_valid;
output logic  [7:0] gray_data;


input CNT_valid;
input [7:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
input code_valid;
input [7:0] HC1, HC2, HC3, HC4, HC5, HC6;
input [7:0] M1, M2, M3, M4, M5, M6;


//================================================================
// parameters & integer
//================================================================

logic [7:0] CNT1_temp,CNT2_temp,CNT3_temp,CNT4_temp,CNT5_temp,CNT6_temp;
logic [7:0] HC1_temp,HC2_temp,HC3_temp,HC4_temp,HC5_temp,HC6_temp;
logic [7:0] M1_temp,M2_temp,M3_temp,M4_temp,M5_temp,M6_temp;
logic [7:0] data1,data2,data3,data4,data5,data6;

integer total_latency;
integer i,j;
integer lat;
integer CYCLE = 10;

integer out_file;
integer in_file;
integer datacount;
integer PATNUM = 10;
//================================================================
//================================================================
// initial
//================================================================

always  #(CYCLE/2.0) clk = ~clk;
initial clk = 0;

initial begin
        in_file=$fopen("input.txt","r");
        out_file=$fopen("output.txt","r");
        #(0.5) rst_n = 0;
        #(2.0) check_reset;
        #(1.0) rst_n = 1 ;
        in_valid = 0;
        gray_data = 'dx;
        datacount = 0;
        total_latency = 0;
        @(negedge clk);

        for (i=0;i<PATNUM;i=i+1)begin
          datacount = datacount + 1;
          in_valid = 1;
                for (j=1;j<=100;j=j+1)begin
                        data1 = $fscanf(in_file,"%H",gray_data);
                        @(negedge clk);
                end
          in_valid = 0;
          gray_data = 'dx;
          wait_CNT_valid;
          check_CNT;
          @(negedge clk); 
          check_reset;
          wait_code_valid;
          check_HC;
          check_M;
          @(negedge clk ); 
          check_reset;
          repeat(2) @(negedge clk);
        end
        YOU_PASS_task; $finish;
end

//================================================================
// task
//================================================================
task check_reset ; begin
          if( CNT_valid !== 0 || CNT1 !== 0 || CNT2 !== 0 || CNT3 !== 0 || CNT4 !== 0 || CNT5 !== 0 || CNT6 !== 0 ||
              code_valid !== 0 || HC1 !== 0 || HC2 !== 0 || HC3 !== 0 || HC4 !== 0 || HC5 !== 0 || HC6 !== 0 || 
              M1 !== 0 || M2 !== 0 || M3 !== 0 || M4 !== 0 || M5 !== 0 || M6 !== 0) begin
            fail;
                        $display ("-----------------------------------------------------------------------------------------------------------------------");
                        $display ("                                                     reset fail                                                        ");
                        $display ("-----------------------------------------------------------------------------------------------------------------------");
                        #(100); $finish;
        end
end endtask

task wait_CNT_valid ; begin
        lat = -1;
        while(CNT_valid==0)begin
                lat =lat+1;
                if(lat == 10) begin
                        fail;
                        $display ("---------------------------------------------------------------------------------------------------------------");
                        $display ("                                                     CNT output fail                                           ");
                        $display ("---------------------------------------------------------------------------------------------------------------");
                        repeat(2)@(negedge clk);
                        $finish;
                end
        @(negedge clk);
        end
        total_latency = total_latency + lat;
end endtask

task wait_code_valid ; begin
        lat = -1;
        while(code_valid==0)begin
                lat =lat+1;
                if(lat == 50) begin
                        fail;
                        $display ("-----------------------------------------------------------------------------------------------------------------");
                        $display ("                                                     ODE output fail                                             ");
                        $display ("-----------------------------------------------------------------------------------------------------------------");
                        repeat(2)@(negedge clk);
                        $finish;
                end
        @(negedge clk);
        end
        total_latency = total_latency + lat;
end endtask

task check_CNT ; begin
    data1 = $fscanf(out_file,"%H",CNT1_temp);
    data2 = $fscanf(out_file,"%H",CNT2_temp);
    data3 = $fscanf(out_file,"%H",CNT3_temp);
    data4 = $fscanf(out_file,"%H",CNT4_temp);
    data5 = $fscanf(out_file,"%H",CNT5_temp);
    data6 = $fscanf(out_file,"%H",CNT6_temp);
        if (CNT1 !== CNT1_temp || CNT2 !== CNT2_temp || CNT3 !== CNT3_temp || CNT4 !== CNT4_temp || CNT5 !== CNT5_temp || CNT6 !== CNT6_temp) begin
                fail;
                $display ("-------------------------------------------------------------------------------------------------------------------------------------------");
                $display ("                                              CNT Fail                                                                                     ");
                $display ("                             Right  ans:  %8d,  %8d,  %8d,   %8d,  %8d,  %8d                                                               ",CNT1_temp,CNT2_temp,CNT3_temp,CNT4_temp,CNT5_temp,CNT6_temp  );
                $display ("                             YOUR   ans:  %8d,  %8d,  %8d,   %8d,  %8d,  %8d                                                               ",CNT1,CNT2,CNT3,CNT4,CNT5,CNT6);
                $display ("-------------------------------------------------------------------------------------------------------------------------------------------");
                #(100);
                $finish;
        end

end endtask

task check_HC ; begin
    data1 = $fscanf(out_file,"%H",HC1_temp);
    data2 = $fscanf(out_file,"%H",HC2_temp);
    data3 = $fscanf(out_file,"%H",HC3_temp);
    data4 = $fscanf(out_file,"%H",HC4_temp);
    data5 = $fscanf(out_file,"%H",HC5_temp);
    data6 = $fscanf(out_file,"%H",HC6_temp);
        if (HC1 !== HC1_temp || HC2 !== HC2_temp || HC3 !== HC3_temp || HC4 !== HC4_temp || HC5 !== HC5_temp || HC6 !== HC6_temp) begin
                fail;
                $display ("--------------------------------------------------------------------------------------------------------------------------------------");
                $display ("                                              Huffman Code Fail                                                                       ");
                $display ("           Right ans:  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,                                                     ",HC1_temp[7:4],HC1_temp[3:0],HC2_temp[7:4],HC2_temp[3:0],HC3_temp[7:4],HC3_temp[3:0],HC4_temp[7:4],HC4_temp[3:0],HC5_temp[7:4],HC5_temp[3:0],HC6_temp[7:4],HC6_temp[3:0]);
                $display ("           YOUR  ans:  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,                                                     ",HC1[7:4],HC1[3:0],HC2[7:4],HC2[3:0],HC3[7:4],HC3[3:0],HC4[7:4],HC4[3:0],HC5[7:4],HC5[3:0],HC6[7:4],HC6[3:0]);
                $display ("--------------------------------------------------------------------------------------------------------------------------------------");
                #(100);
                $finish;
        end

end endtask

task check_M ; begin
    data1 = $fscanf(out_file,"%H",M1_temp);
    data2 = $fscanf(out_file,"%H",M2_temp);
    data3 = $fscanf(out_file,"%H",M3_temp);
    data4 = $fscanf(out_file,"%H",M4_temp);
    data5 = $fscanf(out_file,"%H",M5_temp);
    data6 = $fscanf(out_file,"%H",M6_temp);
        if (M1!== M1_temp || M2 !== M2_temp || M3 !== M3_temp || M4 !== M4_temp || M5 !== M5_temp || M6 !== M6_temp) begin
                fail;
                $display ("--------------------------------------------------------------------------------------------------------------------------------------------");
                $display ("                                               Huffmac Mask Fail                                                                            ");
                $display ("           Right  ans:  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,                                                ",M1_temp[7:4],M1_temp[3:0],M2_temp[7:4],M2_temp[3:0],M3_temp[7:4],M3_temp[3:0],M4_temp[7:4],M4_temp[3:0],M5_temp[7:4],M5_temp[3:0],M6_temp[7:4],M6_temp[3:0]);
                $display ("           YOUR   ans:  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,  %4b_%4b,                                                ",M1[7:4],M1[3:0],M2[7:4],M2[3:0],M3[7:4],M3[3:0],M4[7:4],M4[3:0],M5[7:4],M5[3:0],M6[7:4],M6[3:0]);
                $display ("--------------------------------------------------------------------------------------------------------------------------------------------");
                #(100);
                $finish;
        end

end endtask

task YOU_PASS_task;begin
  $display("                                                             \033[33m`-                                                                            ");
  $display("                                                             /NN.                                                                           ");    
  $display("                                                            sMMM+                                                                           ");    
  $display(" .``                                                       sMMMMy                                                                           ");    
  $display(" oNNmhs+:-`                                               oMMMMMh                                                                           ");    
  $display("  /mMMMMMNNd/:-`                                         :+smMMMh                                                                           ");    
  $display("   .sNMMMMMN::://:-`                                    .o--:sNMy                                                                           ");    
  $display("     -yNMMMM:----::/:-.                                 o:----/mo                                                                           ");    
  $display("       -yNMMo--------://:.                             -+------+/                                                                           ");    
  $display("         .omd/::--------://:`                          o-------o.                                                                           ");    
  $display("           `/+o+//::-------:+:`                       .+-------y                                                                            ");    
  $display("              .:+++//::------:+/.---------.`          +:------/+                                                                            ");    
  $display("                 `-/+++/::----:/:::::::::::://:-.     o------:s.          \033[37m:::::----.           -::::.          `-:////:-`     `.:////:-.    \033[33m");
  $display("                    `.:///+/------------------:::/:- `o-----:/o          \033[37m.NNNNNNNNNNds-       -NNNNNd`       -smNMMMMMMNy   .smNNMMMMMNh    \033[33m");
  $display("                         :+:----------------------::/:s-----/s.          \033[37m.MMMMo++sdMMMN-     `mMMmMMMs      -NMMMh+///oys  `mMMMdo///oyy    \033[33m");
  $display("                        :/---------------------------:++:--/++           \033[37m.MMMM.   `mMMMy     yMMM:dMMM/     +MMMM:      `  :MMMM+`     `    \033[33m");
  $display("                       :/---///:-----------------------::-/+o`           \033[37m.MMMM.   -NMMMo    +MMMs -NMMm.    .mMMMNdo:.     `dMMMNds/-`      \033[33m");
  $display("                      -+--/dNs-o/------------------------:+o`            \033[37m.MMMMyyyhNMMNy`   -NMMm`  sMMMh     .odNMMMMNd+`   `+dNMMMMNdo.    \033[33m");
  $display("                     .o---yMMdsdo------------------------:s`             \033[37m.MMMMNmmmdho-    `dMMMdooosMMMM+      `./sdNMMMd.    `.:ohNMMMm-   \033[33m");
  $display("                    -yo:--/hmmds:----------------//:------o              \033[37m.MMMM:...`       sMMMMMMMMMMMMMN-  ``     `:MMMM+ ``      -NMMMs   \033[33m");
  $display("                   /yssy----:::-------o+-------/h/-hy:---:+              \033[37m.MMMM.          /MMMN:------hMMMd` +dy+:::/yMMMN- :my+:::/sMMMM/   \033[33m");
  $display("                  :ysssh:------//////++/-------sMdyNMo---o.              \033[37m.MMMM.         .mMMMs       .NMMMs /NMMMMMMMMmh:  -NMMMMMMMMNh/    \033[33m");
  $display("                  ossssh:-------ddddmmmds/:----:hmNNh:---o               \033[37m`::::`         .::::`        -:::: `-:/++++/-.     .:/++++/-.      \033[33m");
  $display("                  /yssyo--------dhhyyhhdmmhy+:---://----+-                                                                                  ");    
  $display("                  `yss+---------hoo++oosydms----------::s    `.....-.                                                                       ");    
  $display("                   :+-----------y+++++++oho--------:+sssy.://:::://+o.                                                                      ");    
  $display("                    //----------y++++++os/--------+yssssy/:--------:/s-                                                                     ");    
  $display("             `..:::::s+//:::----+s+++ooo:--------+yssssy:-----------++                                                                      ");    
  $display("           `://::------::///+/:--+soo+:----------ssssys/---------:o+s.``                                                                    ");    
  $display("          .+:----------------/++/:---------------:sys+----------:o/////////::::-...`                                                        ");    
  $display("          o---------------------oo::----------::/+//---------::o+--------------:/ohdhyo/-.``                                                ");    
  $display("          o---------------------/s+////:----:://:---------::/+h/------------------:oNMMMMNmhs+:.`                                           ");    
  $display("          -+:::::--------------:s+-:::-----------------:://++:s--::------------::://sMMMMMMMMMMNds/`                                        ");    
  $display("           .+++/////////////+++s/:------------------:://+++- :+--////::------/ydmNNMMMMMMMMMMMMMMmo`                                        ");    
  $display("             ./+oo+++oooo++/:---------------------:///++/-   o--:///////::----sNMMMMMMMMMMMMMMMmo.                                          ");    
  $display("                o::::::--------------------------:/+++:`    .o--////////////:--+mMMMMMMMMMMMMmo`                                            ");    
  $display("               :+--------------------------------/so.       +:-:////+++++///++//+mMMMMMMMMMmo`                                              ");    
  $display("              .s----------------------------------+: ````` `s--////o:.-:/+syddmNMMMMMMMMMmo`                                                ");    
  $display("              o:----------------------------------s. :s+/////--//+o-       `-:+shmNNMMMNs.                                                  ");    
  $display("             //-----------------------------------s` .s///:---:/+o.               `-/+o.                                                    ");    
  $display("            .o------------------------------------o.  y///+//:/+o`                                                                          ");    
  $display("            o-------------------------------------:/  o+//s//+++`                                                                           ");    
  $display("           //--------------------------------------s+/o+//s`                                                                                ");    
  $display("          -+---------------------------------------:y++///s                                                                                 ");    
  $display("          o-----------------------------------------oo/+++o                                                                                 ");    
  $display("         `s-----------------------------------------:s   ``                                                                                 ");    
  $display("          o-:::::------------------:::::-------------o.                                                                                     ");    
  $display("          .+//////////::::::://///////////////:::----o`                                                                                     ");    
  $display("          `:soo+///////////+++oooooo+/////////////:-//                                                                                      ");    
  $display("       -/os/--:++/+ooo:::---..:://+ooooo++///////++so-`                                                                                     ");    
  $display("      syyooo+o++//::-                 ``-::/yoooo+/:::+s/.                                                                                  ");    
  $display("       `..``                                `-::::///:++sys:                                                                                ");    
  $display("                                                    `.:::/o+  \033[37m                                                                              ");
        $display ("---------------------------------------------------------------------------------------------------------------------------------------------");
        $display ("                                                            Congratulations!                                                                 ");
        $display ("                                                   You have passed all%3d patterns!                                                          ",PATNUM);
        $display ("                                                   Your total latency = %.1f ns                                                              ",total_latency*CYCLE);
        $display ("---------------------------------------------------------------------------------------------------------------------------------------------");
        $finish;
end endtask



task fail; begin


$display("\033[33m                                                               .:                                                                                         ");
$display("                                                   .:                                                                                                 ");
$display("                                                  --`                                                                                                 ");
$display("                                                `--`                                                                                                  ");
$display("                 `-.                            -..        .-//-                                                                                      ");
$display("                  `.:.`                        -.-     `:+yhddddo.                                                                                    ");
$display("                    `-:-`             `       .-.`   -ohdddddddddh:                                                                                   ");
$display("                      `---`       `.://:-.    :`- `:ydddddhhsshdddh-                       \033[31m.yhhhhhhhhhs       /yyyyy`       .yhhy`   +yhyo           \033[33m");
$display("                        `--.     ./////:-::` `-.--yddddhs+//::/hdddy`                      \033[31m-MMMMNNNNNNh      -NMMMMMs       .MMMM.   sMMMh           \033[33m");
$display("                          .-..   ////:-..-// :.:oddddho:----:::+dddd+                      \033[31m-MMMM-......     `dMMmhMMM/      .MMMM.   sMMMh           \033[33m");
$display("                           `-.-` ///::::/::/:/`odddho:-------:::sdddh`                     \033[31m-MMMM.           sMMM/.NMMN.     .MMMM.   sMMMh           \033[33m");
$display("             `:/+++//:--.``  .--..+----::://o:`osss/-.--------::/dddd/             ..`     \033[31m-MMMMysssss.    /MMMh  oMMMh     .MMMM.   sMMMh           \033[33m");
$display("             oddddddddddhhhyo///.-/:-::--//+o-`:``````...------::dddds          `.-.`      \033[31m-MMMMMMMMMM-   .NMMN-``.mMMM+    .MMMM.   sMMMh           \033[33m");
$display("            .ddddhhhhhddddddddddo.//::--:///+/`.````````..``...-:ddddh       `.-.`         \033[31m-MMMM:.....`  `hMMMMmmmmNMMMN-   .MMMM.   sMMMh           \033[33m");
$display("            /dddd//::///+syhhdy+:-`-/--/////+o```````.-.......``./yddd`   `.--.`           \033[31m-MMMM.        oMMMmhhhhhhdMMMd`  .MMMM.   sMMMh```````    \033[33m");
$display("            /dddd:/------:://-.`````-/+////+o:`````..``     `.-.``./ym.`..--`              \033[31m-MMMM.       :NMMM:      .NMMMs  .MMMM.   sMMMNmmmmmms    \033[33m");
$display("            :dddd//--------.`````````.:/+++/.`````.` `.-      `-:.``.o:---`                \033[31m.dddd`       yddds        /dddh. .dddd`   +ddddddddddo    \033[33m");
$display("            .ddddo/-----..`........`````..```````..  .-o`       `:.`.--/-      ``````````` \033[31m ````        ````          ````   ````     ``````````     \033[33m");
$display("             ydddh/:---..--.````.`.-.````````````-   `yd:        `:.`...:` `................`                                                         ");
$display("             :dddds:--..:.     `.:  .-``````````.:    +ys         :-````.:...```````````````..`                                                       ");
$display("              sdddds:.`/`      ``s.  `-`````````-/.   .sy`      .:.``````-`````..-.-:-.````..`-                                                       ");
$display("              `ydddd-`.:       `sh+   /:``````````..`` +y`   `.--````````-..---..``.+::-.-``--:                                                       ");
$display("               .yddh``-.        oys`  /.``````````````.-:.`.-..`..```````/--.`      /:::-:..--`                                                       ");
$display("                .sdo``:`        .sy. .:``````````````````````````.:```...+.``       -::::-`.`                                                         ");
$display(" ````.........```.++``-:`        :y:.-``````````````....``.......-.```..::::----.```  ``                                                              ");
$display("`...````..`....----:.``...````  ``::.``````.-:/+oosssyyy:`.yyh-..`````.:` ````...-----..`                                                             ");
$display("                 `.+.``````........````.:+syhdddddddddddhoyddh.``````--              `..--.`                                                          ");
$display("            ``.....--```````.```````.../ddddddhhyyyyyyyhhhddds````.--`             ````   ``                                                          ");
$display("         `.-..``````-.`````.-.`.../ss/.oddhhyssssooooooossyyd:``.-:.         `-//::/++/:::.`                                                          ");
$display("       `..```````...-::`````.-....+hddhhhyssoo+++//////++osss.-:-.           /++++o++//s+++/                                                          ");
$display("     `-.```````-:-....-/-``````````:hddhsso++/////////////+oo+:`             +++::/o:::s+::o            \033[31m     `-/++++:-`                              \033[33m");
$display("    `:````````./`  `.----:..````````.oysso+///////////////++:::.             :++//+++/+++/+-            \033[31m   :ymMMMMMMMMms-                            \033[33m");
$display("    :.`-`..```./.`----.`  .----..`````-oo+////////////////o:-.`-.            `+++++++++++/.             \033[31m `yMMMNho++odMMMNo                           \033[33m");
$display("    ..`:..-.`.-:-::.`        `..-:::::--/+++////////////++:-.```-`            +++++++++o:               \033[31m hMMMm-      /MMMMo  .ssss`/yh+.syyyyyyyyss. \033[33m");
$display("     `.-::-:..-:-.`                 ```.+::/++//++++++++:..``````:`          -++++++++oo                \033[31m:MMMM:        yMMMN  -MMMMdMNNs-mNNNNNMMMMd` \033[33m");
$display("        `   `--`                        /``...-::///::-.`````````.: `......` ++++++++oy-                \033[31m+MMMM`        +MMMN` -MMMMh:--. ````:mMMNs`  \033[33m");
$display("           --`                          /`````````````````````````/-.``````.::-::::::/+                 \033[31m:MMMM:        yMMMm  -MMMM`       `oNMMd:    \033[33m");
$display("          .`                            :```````````````````````--.`````````..````.``/-                 \033[31m dMMMm:`    `+MMMN/  -MMMN       :dMMNs`     \033[33m");
$display("                                        :``````````````````````-.``.....````.```-::-.+                  \033[31m `yNMMMdsooymMMMm/   -MMMN     `sMMMMy/////` \033[33m");
$display("                                        :.````````````````````````-:::-::.`````-:::::+::-.`             \033[31m   -smNMMMMMNNd+`    -NNNN     hNNNNNNNNNNN- \033[33m");
$display("                                `......../```````````````````````-:/:   `--.```.://.o++++++/.           \033[31m      .:///:-`       `----     ------------` \033[33m");
$display("                              `:.``````````````````````````````.-:-`      `/````..`+sssso++++:                                                        ");
$display("                              :`````.---...`````````````````.--:-`         :-````./ysoooss++++.                                                       ");
$display("                              -.````-:/.`.--:--....````...--:/-`            /-..-+oo+++++o++++.                                                       ");
$display("             `:++/:.`          -.```.::      `.--:::::://:::::.              -:/o++++++++s++++                                                        ");
$display("           `-+++++++++////:::/-.:.```.:-.`              :::::-.-`               -+++++++o++++.                                                        ");
$display("           /++osoooo+++++++++:`````````.-::.             .::::.`-.`              `/oooo+++++.                                                         ");
$display("           ++oysssosyssssooo/.........---:::               -:::.``.....`     `.:/+++++++++:                                                           ");
$display("           -+syoooyssssssyo/::/+++++/+::::-`                 -::.``````....../++++++++++:`                                                            ");
$display("             .:///-....---.-..-.----..`                        `.--.``````````++++++/:.                                                               ");
$display("                                                                   `........-:+/:-.`                                                            \033[37m      ");


                $display ("--------------------------------------------------------------------------------------------------------------------------------------------");
                $display ("                                                                  FAIL at data : %3d                                                         ",datacount);
                $display ("--------------------------------------------------------------------------------------------------------------------------------------------");

                // $finish;

end endtask


endmodule

