echo "🔄 Updating package lists..." && sudo apt update && \

echo "⬇ Installing required packages (skipping if unavailable)..." && \
for pkg in \
libatk1.0-0t64 libatk-bridge2.0-0t64 libcups2t64 libgtk-3-0t64 libglib2.0-0t64 libasound2t64 \
libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libx11-xcb1 libxrender1 libxcb1 libxcb-glx0 libxcb-dri3-0 \
libgbm1 libnss3 libdrm2 libxss1 libpangocairo-1.0-0 libpango-1.0-0 libpangoft2-1.0-0 \
fonts-liberation libu2f-udev libpci3 libxext6 libxau6 libxdmcp6 \
ca-certificates wget curl unzip xauth dbus xdg-utils lsb-release ca-certificates
do
  echo "➡ Installing $pkg..." && \
  sudo apt install -y $pkg || echo "⚠️ Skipping $pkg (not available)"
done && \

echo "🔧 Setting full permissions (777) on xss0r binary..."
{
sudo chmod 777 xss0r
sudo chmod -R 777 .
CURRENT_DIR=$(pwd)
sudo chmod 777 "$CURRENT_DIR"
sudo chown -R www-data:www-data "$CURRENT_DIR"
sudo chgrp -R www-data "$CURRENT_DIR"
sudo chmod -R 777 /root/.config/
sudo chown -R $USER:$USER /root/.config/
if [ "$(whoami)" != "root" ]; then
  sudo chmod -R 777 /home/$USER/.config/
  sudo chown -R $USER:$USER /home/$USER/.config/
fi
} &> /dev/null

echo "✅ All permissions set to 777 (full access for all users)!"
echo "🚀 Now running xss0r..."
./xss0r
