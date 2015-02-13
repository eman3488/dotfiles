# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


##### PORT FWD
alias busforwarddev="ssh -f wassere@amcvc-db0024-ib -L 5005:10.232.41.18:5005 -N"
alias busforwardnyqa="ssh -f wassere@10.131.160.25 -L 5006:10.232.41.76:5007 -N"
alias busforwardnjqa="ssh -f wassere@10.131.160.25 -L 5006:10.232.41.6:5007 -N"
alias tlisten="/home/wassere/workspace/rediplus-redibus/tlisten/build/binaries/tlistenExecutable/tlisten"
alias tsend="/home/wassere/workspace/rediplus-redibus/tsend/build/binaries/tsendExecutable/tsend"

##### GRADLE #####
export PATH=$PATH:/home/wassere/gradle-2.0/bin
export GRADLE_REPOSITORY=~/.gradleRepositoryLocal
export ARTIFACTORY=http://artifactory.rdti.com/artifactory/repo
export ARTIFACTORY_DEPLOY_USER="admin"
export ARTIFACTORY_DEPLOY_PASS="password"
export SYBASE=/opt/sybase
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sybase/OCS-15_0/lib


export TIBCO_TRANSPORT_SERVICE="UNUSED"
export TIBCO_TRANSPORT_NETWORK="UNUSED"
export TIBCO_TRANSPORT_DAEMON="amcvc-db0010:5005"

export PERL5LIB=$PERL5LIB:/home/wassere/workspace/perl/lib

# user specific aliases and functions
alias winvdi='/usr/bin/rdesktop -u wassere -d redi -a 24 -z -g 1920x1200 -r sound:remote vdi515.redi.com &'
alias intellij='/home/wassere/idea-IU-139.1117.1/bin/idea.sh &'
alias wdog='javaws -verbose /usr/bin/watchdog-4.2.5.jnlp'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fsrc='find . -type f \( -name "*.h" -o -name "*.H" -o -name "*.cpp" -o -name "*.c" -o -name "*.hxx" -o -name "*.cxx" -o -name "*.hpp" -o -name "*.inl" -o -name "*.C" -o -name "*.gradle" -o -name "*.groovy" \) | fgrep -v .svn | fgrep -v linux5_64 | xargs fgrep $*'
alias diskspace="du -s | sort -n -r |more"
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias h='history'
alias j='jobs -l'
alias c='clear'
alias ll='ls -alrt --color=auto --group-directories-first'
alias ..='cd ..'

alias cdp='cd /home/wassere/workspace/rediplus-rt/trunk/reditech/possrv; ls -alrt'
alias startpos='/var/redi/runtime/possrv/avga-Primary/scripts/start_possrv.ksh'
alias stoppos='/var/redi/runtime/possrv/avga-Primary/scripts/stop_possrv.ksh'
alias bouncepos='stoppos && startpos'
alias makej='make -j$((1 + `grep -c processor /proc/cpuinfo`)) || make -j1'

alias svnst='svn st | grep -v ?'
alias cleanGradle="rm -rf ${GRADLE_REPOSITORY} ; rm -rf ~/.gradle/caches > /dev/null 2>&1"
alias cleanBuildDirs='find . -type d -name codegen -exec rm -rf {} + && find . -type d -name build -exec rm -rf {} +'
alias buildServerPlugin='cd /home/wassere/workspace/rediplus-rt/trunk/gradle; gradle clean; gradle; cd -'
alias makeGradleConfig='echo "version=LATEST-SNAPSHOT" > gradle.properties; svn add gradle.properties; echo "rootProject.name=\"`pwd | rev | cut -d/ -f1 | rev`\"" > settings.gradle; svn add settings.gradle'

alias screen='screen -D -R -h 200'

export ALTERNATE_EDITOR=""
export EDITOR=vim
export HISTFILESIZE=3000


extract() {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

netinfo () {
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	echo ""
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	echo ""
	/sbin/ifconfig | awk /'inet addr/ {print $4}'
	echo "---------------------------------------------------"
}

createTag(){
    echo "*********************************"
    echo "*** HERE WE GO TAG CREATION! ***"
    echo "*********************************"
    if [[ $# -ne 3 ]] ; then
        echo "3 arguments must be supplied:"
        echo
        echo "USAGE: createTag comment branch_from tag_name"
        echo "*********************************"
        return 0
    fi
    if [[ ! $3 =~ "REDITECH_$(date +"%y")_"[0-9]+"_"[0-9]+ ]] ; then
        echo "Tag name must be in the form 'REDITECH_$(date +"%y")_#_#'"
        echo "*********************************"
        return 0
    fi
    
    echo "Creating SVN tag '$3' from branch '$2'"
    svn copy -m"$1" svn+ssh://$USER@svn.rdti.com/rediplus-rt/$2 svn+ssh://$USER@svn.rdti.com/rediplus-rt/tags/$3 
    echo "Tag created successfully! - Goodbye."
    echo "*********************************"
}
