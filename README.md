<h1 align="center">Dill Public Validator Testnet</h1>

![GRIE3Y1bYAAWkEw](https://github.com/user-attachments/assets/19375a93-58ba-45fc-b317-967dd1883dd2)

* [Twitter](https://x.com/dill_xyz_)
* [Discord](https://discord.com/invite/dill)
* [Explorer](https://andes.dill.xyz/validators)


> You must be choosen as `Andes` role in the discord to be able to join this
>
> Currently, People were selected in 2 phases and will be picked in 2 more phases in next 2 weeks
> 
> Join Galxe [first](https://app.galxe.com/quest/Dill/GCVWntghfL) and be active in discord to get `Andes` role 


## System Requirements (Minimum-Recommended)
| Ram | cpu     | disk                      |
| :-------- | :------- | :-------------------------------- |
| `2 GB`      | `2 Core` | `20-40 GB SSD` |

## 1- Dependecies
```console
sudo apt update && apt upgrade -y
sudo apt install curl make wget clang net-tools pkg-config libssl-dev build-essential jq lz4 gcc unzip snapd -y
```
## 2- Install Node

### 2-1 Download Binaries
```console
cd $HOME && curl -O https://dill-release.s3.ap-southeast-1.amazonaws.com/linux/dill.tar.gz && \
tar -xzvf dill.tar.gz && cd dill
```
### 2-2 Generate Validator Keys
```console
./dill_validators_gen new-mnemonic --num_validators=1 --chain=andes --folder=./
```

Output:
```
ubuntu@ip-xxxx:~/dill$ ./dill_validators_gen new-mnemonic --num_validators=1 --chain=andes --folder=./

***Using the tool on an offline and secure device is highly recommended to keep your mnemonic safe.***

Please choose your language ['1. العربية', '2. ελληνικά', '3. English', '4. Français', '5. Bahasa melayu', '6. Italiano', '7. 日本語', '8. 한국어', '9. Português do Brasil', '10. român', '11. Türkçe', '12. 简体中文']:  [English]: 3
Please choose the language of the mnemonic word list ['1. 简体中文', '2. 繁體中文', '3. čeština', '4. English', '5. Italiano', '6. 한국어', '7. Português', '8. Español']:  [english]: 4
Create a password that secures your validator keystore(s). You will need to re-enter this to decrypt them when you setup your Dill validators.:
Repeat your keystore password for confirmation:
The amount of DILL token to be deposited(2500 by default). [2500]:
This is your mnemonic (seed phrase). Write it down and store it safely. It is the ONLY way to retrieve your deposit.


Creating your keys.
Creating your keystores:	  [####################################]  1/1
Verifying your keystores:	  [####################################]  1/1
Verifying your deposits:	  [####################################]  1/1

Success!
Your keys can be found at: ./validator_keys


Press any key.
ubuntu@ip-xxxx:~/dill$
```

Check if you created validator keys:
```console
ls -ltr ./validator_keys
```
### 2-3 Import your keys to a keystore file
```console
./dill-node accounts import --andes --wallet-dir ./keystore --keys-dir validator_keys/ --accept-terms-of-use
```
### 2-4 Write the password you configured in the previous step into a file:
```console
echo 123@dill > walletPw.txt
```
You can replace `123@dill` as a password

### 2-5 Start light validator
```console
./start_light.sh -p walletPw.txt
```

Output:
```
ubuntu@xxxxx:~/dill$ ./start_light.sh -p walletPw.txt
Option --pwdfile, argument 'walletPw.txt'
Remaining arguments:
using password file at walletPw.txt
start light node
start light node done
ubuntu@xxxxx:~/dill$ nohup: redirecting stderr to stdout
```

### 2-6 Check health node
```console
./health_check.sh -v
```
![image](https://github.com/user-attachments/assets/b56449a2-d409-4505-ad48-773e7de4cfb2)


## 3- Faucet 
> You must be choosen as `Andes` role in the discord to be able to join this testnet
>
> You can get faucet by typing $request `your-evm-address' in Andes channel


## 4- Delegate
### 4-1 Transfer deposit-data file to local system
* I use Mobaxterm client to connect to SSH VPS which is compatible with easy transfering files from VPS to your system

Go to `/dill/validator_keys` directory and transfer `deposit_data-xxxx.json` file to your local system

### 3.2 Upload and Delegate

> Upload deposit_data-xxxx.json in https://staking.dill.xyz/
>
![image](https://github.com/user-attachments/assets/d2a218f7-53cd-4e15-ac9c-3a667440ee10)


> Connect to MetaMask (Site adds Dill Network automatically), Make sure you ahve >2500 $DILL tokens
> 
![Untitled](https://github.com/user-attachments/assets/296d5228-80fe-4243-a456-033f1ac00c18)


> Send Deposit & Sign you wallet transaction request
> 
![Untitled (1)](https://github.com/user-attachments/assets/05a7f5c0-9c16-4307-b639-b4c7fd440c6d)



## 5- Check validator on explorer
> Open your deposit_data-xxxx.json file and Copy your `Pubkey`
>
> Search it here: https://andes.dill.xyz/validators
> 
![image](https://github.com/user-attachments/assets/86dbffd9-86c9-4cfa-b693-a21a1be27975)


## Check Validator
Ensure you are in dill directory
```console
cd ~ && cd $HOME/dill
```

### Check health
```console
./health_check.sh -v
```
![image](https://github.com/user-attachments/assets/b56449a2-d409-4505-ad48-773e7de4cfb2)

### Stop validator
```console
ps -ef | grep dill-node | grep -v grep | awk '{print $2}' | xargs kill
```

### Start validator
```console
./start_light.sh -p walletPw.txt
```

### Check logs
```console
tail -f -n 100 $HOME/dill/light_node/logs/dill.log
```

# Error: if your validator doesn't start or your healthcheck doesnt work

## Change ports

### 1- Stop node
```console
cd ~ && cd $HOME/dill
```

Stop:
```console
ps -ef | grep dill-node | grep -v grep | awk '{print $2}' | xargs kill
```

### 2- Get my files with port configuration
```
rm -rf $HOME/dill/health_check.sh && rm -rf $HOME/dill/start_light.sh && \
wget -O  $HOME/dill/start_light.sh https://raw.githubusercontent.com/0xmoei/dill-validator/main/start_light.sh && \
wget -O  $HOME/dill/health_check.sh https://raw.githubusercontent.com/0xmoei/dill-validator/main/health_check.sh && \
chmod +x health_check.sh && chmod +x start_light.sh
```
Ports in my `start_light.sh` are changed to: 8085 8555 30304 8556
Ports in my `/health_check.sh` are changed to: 8085

* if you have any of these ports using by another process, you can change them


### 3- Start node 
```
./start_light.sh -p walletPw.txt
```
