# Tang-Nano_MIDI_Sounder
 
GW1N-1 FPGAチップを搭載した[Tang Nano FPGAボード](https://jp.seeedstudio.com/Sipeed-Tang-Nano-FPGA-board-powered-by-GW1N-1-FPGA-p-4304.html)で動作するMIDIサウンダです。  
Tang NanoボードのCH552TでUSB-UART変換を行い、38.4kbpsのMIDI UARTメッセージをFPGAに入力すると音が出ます。  
LCDには発音中のスロットが表示されます。 
手っ取り早く試したい方は、impl\pnr\Tang-Nano_MIDI_Sounder.fs をボードに書き込んで下さい。  
なお、真面目にRTL-Simをしていないので、怪しい点が多々あるかと思いますがご了承ください・・・。  
[![](https://img.youtube.com/vi/XFGDiXRbHsQ/0.jpg)](https://www.youtube.com/watch?v=XFGDiXRbHsQ)

# 仕様
- 内部回路動作周波数：9MHz / 72MHz（オンチップ24MHzオシレータよりPLLで生成）
- 発音可能ノート番号：0～127
- 最大同時発音数：64音（ch当たり4和音、計16ch）
- サンプリング周波数：562.5kHz
- MIDI UARTボーレート：38.4kbps
- MIDI UART入力ピン：9
- 音声出力ピン：17 (ΔΣ-DAC出力、1kΩ+0.01uFのLPFと、10uFくらいのDCカットコンデンサを付けて下さい。)
- 動作確認済みLCD：ATM0430D25

# 回路図
![Schematic](doc/Schematic.png)  
※LCDの配線は省略

# 全体構成図
MIDIシーケンサ（Domino）からTang-Nanoボードまでの接続は以下を参考ください。
![SystemBlock](doc/SystemBlock.png)  

# 開発環境
- IDE : GOWIN FPGA Designer Version1.9.2.02 Beta build(35976)

# Resource Usage Summary:
|  Resource  |  Usage |  Utilization  |
| ---------- | ------ | ------------- |
|  Logics  |  442/1152  | 38% |
|  --LUTs,ALUs,ROM16s  |  442(340 LUTs, 102 ALUs, 0 ROM16s)  | - |
|  --SSRAMs(RAM16s)  |  0  | - |
|  Registers  |  146/945  | 15% |
|  --logic Registers  |  143/864  | 16% |
|  --I/O Registers  |  3/81  | 3% |
|  BSRAMs  |  4/4  | 100% |


# 参考
- Tang NanoのFPGAとPC間でUART通信をする https://qiita.com/ciniml/items/05ac7fd2515ceed3f88d
- seeed Sipeed Tang Nano FPGAボード GW1N-1 FPGAチップ搭載 https://jp.seeedstudio.com/Sipeed-Tang-Nano-FPGA-board-powered-by-GW1N-1-FPGA-p-4304.html
- SiPeed Tang Nanoの環境構築(Windows編) https://qiita.com/tomorrow56/items/7e3508ef43d3d11fefab
- MIDIメッセージ一覧 https://www.g200kg.com/jp/docs/tech/midi.html
- MIDIのノートナンバーと周波数の対応表 http://www.asahi-net.or.jp/~HB9T-KTD/music/Japan/Research/DTM/freq_map.html  
  
以下はUSB-UARTからMIDIメッセージを送出するのに使えるツール類
- loopMIDI https://www.tobias-erichsen.de/software/loopmidi.html
- The Hairless MIDI to Serial Bridge https://projectgus.github.io/hairless-midiserial/
