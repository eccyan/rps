rsync -auvzr --rsh="ssh -p 12200" --exclude="*~" --exclude="*.swp" --delete --delete-excluded --password-file=/etc/rsync.passwd ./ sato@182.48.51.39:/home/sato/devel/project/rps
rsync -auvzr --rsh="ssh -p 12200" --exclude="*~" --exclude="*.swp" --exclude="*sql/" --delete --delete-excluded --password-file=/etc/rsync.passwd ./ sato@182.48.51.39:/var/www/rps
