#!/bin/bash

## Minimal Config
echo "
    ergo {
        node {
            mining = false
        }

    }" > ergo.conf
        
## Node start command
echo "
#!/bin/sh  
while true  
do
          java -jar -Xmx1G ergo.jar --mainnet -c ergo.conf > server.log 2>&1 &
            sleep 100
    done" > start.sh
    
chmod +x start.sh

## Download .jar
echo "- Retrieving latest node release.."
LATEST_ERGO_RELEASE=$(curl -s "https://api.github.com/repos/ergoplatform/ergo/releases/latest" | awk -F '"' '/tag_name/{print $4}')
LATEST_ERGO_RELEASE_NUMBERS=$(echo ${LATEST_ERGO_RELEASE} | cut -c 2-)
ERGO_DOWNLOAD_URL=https://github.com/ergoplatform/ergo/releases/download/${LATEST_ERGO_RELEASE}/ergo-${LATEST_ERGO_RELEASE_NUMBERS}.jar
echo "- Downloading Latest known Ergo release: ${LATEST_ERGO_RELEASE}."
curl --silent -L ${ERGO_DOWNLOAD_URL} --output ergo.jar

## Start node
echo "Starting the node..."
echo "Monitor the .log files for any errors"
echo "Please visit https://127.0.0.0.9053/panel to view sync progress." 
echo "                                             .X.88X @.                                              
  .  . .  .  . .  .  . .  .  . .  .  . . :X8S88888XX8@S;8t.   . .  . .  . .  . .  . .  . .  . .  .  
   .       .       .       .       ..%8 88X 88888888@@XXX8@S;8;.       .         .         .      . 
     .  .    .  .    .  .    .  . t8@ 8SX88888888X8888888@@XXX8 8t .      . .  .    . .  .    . .   
 .       .       .       .   .%8 8@SX8X88888888888888@888@8888@8@8% 88..          .         .      .
   .  .    .  .    .  . .;8:X8@8SS88@@888888888@888888888S8888888@8SS88  8@:   .     . .  .    .    
  .    .  .    .  .   :8 @8XX88@8888888888888888%   8888X888888888888888SS8X88:   .      .   .   .  
    .       .    .;8:X8X8@@88@888888888X8888S;t:.. .  .88S888888888X8888888S@88S88t.   .   .      . 
  .   . .    .%% 88@S@8@888@88X8888888 8%  ..      .   :t  ;88888S888888X@88@8S8SX8@ 8        . .   
    .     .  88@X8888888888888888S88%Xt:     .  .          .:;  88@8888@8888@88@88XX@ S  .  .      .
  .    .   .;XS8888@888888X888888@S; .     .     .    .    ..   ;  t88@8888888888888@88t       .  . 
     .   . . %8888888888X88@.:S;;      .     . .   .      .     .  .t. .S888888888888888. .     .   
  .    .   8X@8888888X8X.    .: . .  .   . .      .  .  .   .   .   .  ..t  %888@88888@Xt  . .      
    .     tXS888888888.:      . .   .   .    .  .      .       .   .        :  8@88888888S      . . 
  .   .  : %88888888X;.           .   .    .       .  .   .  .       .  .      X888S88@XS8t . .     
    .    8X8888@8888 ..        .         .    .  .       .      . .   .    .    8@X8888888        . 
  .    .tXS888@8888%:  .     .   .:::::::.::::.::::::::::.::::::.:  .    .      ;SX888@888 t   .    
     . . %88888888@.  .        . @888888888X@88@8888X@888X@88X@88S8.   .    .   ;S88888888X8S.   .  
  .    8X888888@8. .    . . .   .S888888888888888888@8888@88888888% .     .     . X88@88@88@.  .    
    . tX888888888t  .  .      .  @88@8@8888X888X88888888888X888888t: .  .    .     8@8888888 X   .  
  .  : X888888888:.      .  .    S888@88888888@88888888@88X88888X8X.      .   .   :XSX888888S88.    
     8X8888888@X.:  . .   .    . @@88X88@88X88@888888X888888888X88.. . .    .       8@88S@888S8..  .
  . tX@888888S8X ..    .    .   . 88X88888@88@88888%8@8 888888S888@:     .     .  .  8S88888888     
   : X88888888X;. .  .   .    .  .  8X888888888@88SS%tSS%;%t@X;8%   .  .   . .      ..8X8888888 S   
   8X@8888@88S;    .    .   .      ;.X88@88888@88XX;. .  ..          .         . .   ;888888888X8t. 
 .t@88888S@88:  .   .     .    .    .  8@88888888@@88.  .   .  .      .  .  .        . 8@8888@888   
 : X888888888.    .   .      .   .    :t;8S8888888@XX8X.          . .         .  . . .. 8S8888888S% 
 8X88888@888.  .   .   .  .    .        ;;88888X88@@8X@X  . . .  .     . .  .          .S8888888888S
tX@8888X888t.    .   .      .    .     ...  8SX@8888888888:         .      .   .  .  ..  S888X88@@88
SS8888@8888... .   .    .     .   . .    . ;tX888888888XS88;.  .  .   . .       .   .     8@X8888888
.8X8888888t. .        .   .     .     .    . 888@88@888888X     .   .     .  .    .   .   8S888888@@
S 8X88888@      . . .      .  .    .    .  X8%8888X888X@88;  .    .    .       .         8S888888S@8
t X888888@8;  .        . .       .   .   t8%%@8888888X88%:.   .      .   .  .    .  .  .@888888888@:
 888888888X8;.   .  .       .  .       .%8@@88888S@@88@:   .    .  .          .      .  8S88888888  
  8@88888888          .   .       . . :8888888888888@%.  .   .   .    . .  .    .  .   8S8888@8@8S  
  .8S888X888S%.. . .    .    .  .   .88@888888X88888;          .    .        .        @88888@8888   
  ;@88SX888888t .    .     .       .8X8888888@888X::. . .  . .    .   .  .     .  .  . @888888888   
    8%88888@X8%    .   .     . .  SS 8888888888888S%SSSS%SS%S%SSS%:        .        .8@888888888t.  
 . ..8S8888X888      .   .       88@8888X88888@@SX@@8X8X8@@8X8@8@8X.  .  .   .  . . X8888888888; .  
    :%%@8@X88888X. .       .  .  8@8888X8888@8888888888@8888@88888  .  .      .    . @88X88888;   . 
  . . 8888@8888X8     .  .      .8888S@888888888888888@8@8888X8888X.  .   . .      8@88X88@88S  .   
     . S@@888@888 ..   .    .  . 8888888888888@888888X888888888888:..          . .X88888888S8;    . 
   .   :8X8888@88 S .     .      8@88X8888@88@8888@@8888888888S@88;: .  .  .     . @8@888888.. .    
       .888888X8@88t  .     .  . :88888888888888888888888888888888@.     .   .   8@8888888@S.    .  
  .    . X888X888@88    .       ..;t%t%t;:t%t;;:;;%tt;;tt;;:;t%%t  .  .        .X888888@8X8t .     .
    .     8@88888@88: .  .  . .          .     .       . .          .   .  .  .  @8888@888%    . .  
     .   .@8888X888@8X.          . .  .      .    .  .     .  .  .    .        8X8888X888X  .       
  .        ;88@88888S88S . .  .        .  .     .      . .  .   .  .     . :@8XX8888@8888;   .  .  .
    . .     8X8888@88%X888S     .  . .     .  .   . .     .          .  .X:88SX8@8888@88 : .     .  
  .         . @88888888@@X8  8@. .     . .      .     . .    . .  . :@8S88@8888888X8888: .    .     
     .  .   :@8888888888@8@8XS@@S 8@..      . .    .       .   .S88@8@S@@888888@8X8888% .. .   .  . 
  .    .       88888@8888888888@@SS8S88:  .      .   .  .   .t8888S888888888888888@888.  ..  .      
     .     .    S8888888888@888@8888S@@S888% .     .    .S8 88@8@88888888X8888@888Xt%.    .    . .  
  .     .           .S8S888X888X8888888S@XX@8 88%  .t888XXS@88888888888S@888888%.:...   .  .       .
    .    .           .S. S8@88@8888@8888@88@@@%X8888X8S888888@888888@8X8 88 ;t. .. .  .   . . .  .  
  .   .    .             ;% :8888@8888@888888@88@@%@8888888888888@8@888@S%.     .   .               
    .   .               ..  .:. :;888SS88@8888888888888888888888888 :S;       .  .   .  . . . . . . 
  .       .           .      .   .tt %888888X888888888888888S8@ SS...  . . .       .   .            
    .  .    .           .  .   .     .. :X88 S88888@88@88888X.:   .          .  .        .  .  .  . 
  .      .    .   .  .   .      . .     .:. : X8888888:@S        .  . .  . .      .  . .        .   
"

sh start.sh
