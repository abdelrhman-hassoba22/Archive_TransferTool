#!$BASH
# This script is for transferring, archiving, and managing directories and files.

echo "What do you want to execute?"
echo "1- Compress files in .tar.gz format"
echo "2- Data transfer"
read a_t

# case statement. 

case $a_t in
# option 1.
    1) echo "Choose whether you want to archive the files or directories locally or remotely."
       echo "1- locally"
       echo "2- remotely"
       read tar
# sup case for option 1.
       case $tar in
# option 1 for sub case.
           1) read -p "enter name of source file or directory " scr
              read -p "Enter the destination." dest
# if statement to solve problem of ~ sign don't readable in variable.
              if [[ "$scr" == ~* ]] || [[ "$dest" == ~* ]]; then
              scr="${scr/#\~/$HOME}"
              dest="${dest/#\~/$HOME}"
              fi 
# variable manage name of file.
              n1=`echo $scr |awk -F/ '{print$NF} '`
              echo -e "The compressed file will be named: $n1.tar.gz \nDo not include the extension, just the new name; the extension will be added automatically."
              read -p "If you agree with the name, press Enter. If you want to change it, type the new name here:" n2
# variable manage scr.
              sub_scr=`echo $scr |tr -d "$n1"`
              if [[ -z $n2 ]]; then
              tar -czvf $dest/$n1.tar.gz -C $sub_scr $n1 |tr -s '/' 
              elif [[ -n $n2 ]]; then
              tar -czvf $dest/$n2.tar.gz -C $sub_scr $n1 |tr -s '/'
              fi;;
# option 2 for sub case.
           2) read -p "Enter the source file or directory you want to archive." scr_l
              read -p "Enter the destination where you want to store the compressed copy on the remote server." dest_r
              read -p "Enter user_name and host_name or server_ip for remote, examble: USER@192.168.1.5." u_h
# if statement to solve ~ sign problem couldn't readable with read as /home/user/.
              if [[ "$scr_l" == ~* ]]; then
              scr_l="${scr_l/#\~/$HOME}"
              fi
# variable to manage name of file on remote.
              n1=`echo $scr_l |awk -F/ '{print$NF}'`
              echo -e "The name of the compressed file or directory will be $n1.tar.gz on remote \nIf you agree with the default name, press Enter. \nOtherwise, to change it, simply type the new name without the extension, as it will be added automatically." 
              read n2
              if [[ -z "$n2" ]]; then
              tar czf - $scr_l |ssh $u_h "cat > $dest_r/$n1.tar.gz" |tr -s '/'
              elif [[ -n "$n2" ]]; then
              tar czf - $scr_l |ssh $u_h "cat > $dest_r/$n2.tar.gz" |tr -s '/'
              fi        
       esac;;
# option 2 for main case.
    2) echo "Choose whether you want to transfer the files or directory locally or remotely."
       echo "1- locally"
       echo "2- remotely"
       read rsy
# sup case for option 2.
       case $rsy in
# option 1 for sub case.
           1) read -p "enter name of source file or directory " scr
              read -p "Enter the destination." dest
# if statement to solve problem of ~ sign don't readable in variable.
              if [[ "$scr" == ~* ]] || [[ "$dest" == ~* ]]; then
              scr="${scr/#\~/$HOME}"
              dest="${dest/#\~/$HOME}"
              fi
# the command to transfering. 
              rsync -avp $scr $dest;;
# option 2 for sub case.
           2) echo  'Do you want to transfer from the client to the server or from the server to the client?'
              echo "1- Client to server"
              echo "2- Server to client"
              read tran
              case $tran in
                  1)               read -p "Enter source file or directory you want to transfer it: " s_f
                     read -p "Enter the destination you want to transfer to." d_f
                     read -p "Enter user_name and host_name or server_ip for remote, examble: USER@192.168.1.5." u_h
# if to solve ~ problem.
                     if [[ "$s_f" == ~* ]]; then
                     s_f="${s_f/#\~/$HOME}"
                     fi
                     rsync -avzp -e "ssh" $s_f $u_h:$d_f;;
                  2) read -p "Enter the file or directory you will import from the server.:" s_f
                     read -p "Enter the destination where you will place the file on the client.:" d_f
                     read -p "Enter user_name and host_name or server_ip for remote, examble: USER@192.168.1.5." u_h
# if to solve ~ problem.
                     if [[ "$d_f" == ~* ]]; then
                     d_f="${d_f/#\~/$HOME}"
                     fi
                     rsync -avzp $u_h:$s_f $d_f;;
              esac;;
    esac;; 
esac
