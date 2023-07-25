op inject -i tpl/public.key.tpl -o .public.key
op inject -i tpl/private.key.tpl -o .private.key

gpg --import .public.key
gpg --passphrase ${GPG_KEY_PASSPHRASE} --import .private.key