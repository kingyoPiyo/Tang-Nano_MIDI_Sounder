# Tang-Nano_MIDI_Sounder
 
GW1N-1 FPGAチップを搭載した[Tang Nano FPGAボード](https://jp.seeedstudio.com/Sipeed-Tang-Nano-FPGA-board-powered-by-GW1N-1-FPGA-p-4304.html)で動作するMIDIサウンダです。  
Tang Nano FPGAボードのzzピンに38.4kbpsのMIDI UARTメッセージを入力すると音が出ます。  
LCDには発音中のスロットが表示されます。 
手っ取り早く試したい方は、impl\pnr\Tang-Nano_MIDI_Sounder.fs をボードに書き込んで下さい。  
[![](https://img.youtube.com/vi/XFGDiXRbHsQ/0.jpg)](https://www.youtube.com/watch?v=XFGDiXRbHsQ)

# 仕様
- 内部回路動作周波数：9MHz / 72MHz（オンチップ24MHzオシレータよりPLLで生成）
- 発音可能ノート番号：0～127
- 最大同時発音数：64音（ch当たり4和音、計16ch）
- サンプリング周波数：562.5kHz
- MIDI UARTボーレート：38.4kbps
- MIDI UART入力ピン：18
- 音声出力ピン：17 (ΔΣ-DAC出力、1kΩ+0.01uFのLPFと、10uFくらいのDCカットコンデンサを付けて下さい。)


# 開発環境
- IDE : GOWIN FPGA Designer Version1.9.2.02 Beta build(35976)

# 参考
- SiPeed Tang Nanoの環境構築(Windows編) https://qiita.com/tomorrow56/items/7e3508ef43d3d11fefab
- MIDIメッセージ一覧 https://www.g200kg.com/jp/docs/tech/midi.html
- MIDIのノートナンバーと周波数の対応表 https://qiita.com/tomorrow56/items/7e3508ef43d3d11fefab
