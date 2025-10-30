
#!/bin/bash

# --- PROPERTIES DOSYASI ---
PROPS="./config.properties"

if [[ -f "$PROPS" ]]; then
    source "$PROPS"
else
    # properties yoksa input al
    read -p "Aranacak dizin (path) giriniz: " path
    read -p "Aranacak dosya / string (pattern) giriniz: " pattern
    read -p "Mail alıcı adresi giriniz: " mail_to
    read -p "Gmail kullanıcı (from) adresi giriniz: " mail_from
    read -p "Gmail app password giriniz: " mail_pass
fi

echo "[INFO] Arama başlatılıyor: path='$path' pattern='$pattern'"

# --- DOSYA ARAMA ---
found_files=$(find "$path" -type f -iname "*$pattern*" 2>/dev/null)

if [[ -n "$found_files" ]]; then
    echo "[INFO] Dosyalar bulundu:"
    echo "$found_files"
    mail_body="Bulunan dosyalar:\n$found_files"
else
    echo " Adında '$pattern' bulunan dosya bulunamadı."
    mail_body="Bulunamadı: '$pattern' içeren dosya '$path' altında bulunamadı$
fi

# --- MAIL GÖNDERME ---
echo -e "$mail_body" | mailx -v \
    -s "Dosya Arama Sonucu" \
    -S nss-config-dir=/etc/pki/nssdb \
    -S smtp="smtp.gmail.com:587" \
    -S smtp-use-starttls \
    -S ssl-verify=ignore \
    -S smtp-auth=login \
    -S smtp-auth-user="$mail_from" \
    -S smtp-auth-password="$mail_pass" \
    -r "$mail_from" \
    "$mail_to"

echo "[MAIL] Gönderildi: $mail_to"


