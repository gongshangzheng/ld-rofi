 # ld-rofi.sh                                                                                                                                                                                                      
`ld-rofi.sh` is a Bash script designed to easily check your bookmarks on linkding with rofi.

 ## Prerequisites                                                                                                                                                       

 - **Linkding**: Make sure you have a server which hosts the service of linkding.
 - **curl**: In order to get the feed.
 - **xmlstarlet**: In order to decode the feed. 
 - **Rofi**: To display bookmarks.

You can install them using: 

On ubuntu:

```bash
sudo apt install rofi xmlstarlet curl
```

## Installation                                                                                                    

 1 Clone this repository or download the ld-rofi.sh script.
 2 Make the script executable:

```bash
chmod +x ld-rofi.sh
```

## Usage

Run the script using the following command:

```bash
 ./ld-rofi.sh
 ```

## Customization

Edit the ld-rofi.sh file to add or modify the commands you want to access through Rofi. Each command should be added to the list within the script.

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements.
