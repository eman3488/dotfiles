# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

aa_256 ()
{
	(	
	x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
	for i in {0..256};
	do
		o=00$i;
		echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
	done 
	)
}

if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 256)
    else
      MAGENTA=$(tput setaf 5)
      BLUE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      RED=$(tput setaf 1)
      WHITE=$(tput setaf 7)
      CYAN=$(tput setaf 6)
      BLINK=$(tput blink)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    BLUE="\033[1;34m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

#export PS1="\u@\h \w \\$"
export PS1="\[$RED\][\[$CYAN\]\u\[$RESET\]@\[$GREEN\]\h \[$MAGENTA\]\w\[$RED\]] \[$RESET\]\[$BLINK\]$\[$RESET\] "

export JENKINS_API_TOKEN=c2735bc86cf7e13a55dc1f8c4c6a9fb5

##### PORT FWD
alias busforwarddev="ssh -f wassere@amcvc-db0024-ib -L 5005:10.232.41.18:5005 -N"
alias busforwardnyqa="ssh -f wassere@10.131.160.25 -L 5006:10.232.41.76:5007 -N"
alias busforwardnjqa="ssh -f wassere@10.131.160.25 -L 5006:10.232.41.6:5007 -N"

alias tlistendev="ssh -t wassere@busproxy_backend1-AM2-dev \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008\" \";\" \"exec /bin/bash\""
alias tlistenqa="ssh -t wassere@busproxy_backend-AM1-staging \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008\" \";\" \"exec /bin/bash\""
alias tlistenprod="ssh -t wassere@ivdfe-day1-AM2-prod \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008\" \";\" \"exec /bin/bash\""

alias checktlistendev="ssh -t wassere@busproxy_backend1-AM2-dev \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008; checkstcatalogs\""
alias checktlistenqa="ssh -t wassere@busproxy_backend-AM1-staging \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008; checkstcatalogs\""
alias checktlistenprod="ssh -t wassere@ivdfe-day1-AM2-prod \"export PATH=$PATH:/var/redi/runtime/tlisten/main/bin; export LD_LIBRARY_PATH=:/opt/sybase/OCS-15_0/lib:/opt/sybase/OCS-15_0/lib; export TIBCO_TRANSPORT_SERVICE=UNUSED; export TIBCO_TRANSPORT_NETWORK=UNUSED; export TIBCO_TRANSPORT_DAEMON=localhost:5008; checkstcatalogs\""
alias checktlisten="echo '** DEV **' && checktlistendev && echo && echo '** QA **' && checktlistenqa && echo && echo '** PROD **' && checktlistenprod"

alias tsend="/home/wassere/workspace/rediplus-redibus/tsend/build/binaries/tsendExecutable/tsend"

alias devstmetrics='watch -n1 "echo /METRICS/status | nc s2abcd0048.rdti.com 1646"'
alias qastmetrics='watch -n1 "echo /METRICS/status | nc scscom108.rdti.com 1646"'
alias prodstmetrics='watch -n1 "echo /METRICS/status | nc s2abcp0088.rdti.com 1646"'

alias watchdog='javaws /home/eric/Desktop/watchdog-4.2.12.jnlp &'

##### CHEF #####
alias chefhost="ssh wassere@chef-workstation.rdti.com"
alias chefdev="cd /home/wassere/chef-repo && source gf-dev.sh"
alias chefdev="cd /home/wassere/chef-repo && source gf-qa.sh"

##### GRADLE #####
export PATH=$PATH:/usr/local/gradle-2.0/bin
export GRADLE_REPOSITORY=~/.gradleRepositoryLocal
export ARTIFACTORY=http://artifactory.rdti.com/artifactory/repo
export ARTIFACTORY_DEPLOY_USER="admin"
export ARTIFACTORY_DEPLOY_PASS="password"
export SYBASE=/opt/sybase
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sybase/OCS-15_0/lib
alias gradle21='/usr/local/gradle-2.11/bin/gradle'

export TIBCO_TRANSPORT_SERVICE="UNUSED"
export TIBCO_TRANSPORT_NETWORK="UNUSED"
export TIBCO_TRANSPORT_DAEMON="ivdfe-day1-AM2-dev.rdti.com:5005"

export PERL5LIB=$PERL5LIB:/home/wassere/workspace/perl/lib

# user specific aliases and functions
alias homelap='/usr/bin/rdesktop -g 1920x1200 -r clipboard:PRIMARYCLIPBOARD 74.71.63.113:3389 &'
alias winvdi='/usr/bin/rdesktop -u wassere -d redi -a 24 -z -g 1920x1200 -r sound:remote vdi515.redi.com &'
alias winvdifull='/usr/bin/rdesktop -u wassere -d redi -a 24 -z -f -r sound:remote vdi515.redi.com &'
alias intellij='/home/wassere/idea-IU-141.177.4/bin/idea.sh &'

alias latestoms='curl "http://artifactory.rdti.com/artifactory/api/search/latestVersion?g=com.redi.oms&a=omsStream&repos=libs-release-local" && echo && echo'
alias latestpresentation='curl "http://artifactory.rdti.com/artifactory/api/search/latestVersion?g=com.redi.spreadtrader&a=presentation&repos=libs-release-local" && echo && echo'
alias latestplatform='curl "http://artifactory.rdti.com/artifactory/api/search/latestVersion?g=com.redi.platform&a=platform&repos=libs-release-local" && echo && echo'
alias lateststapi='curl "http://artifactory.rdti.com/artifactory/api/search/latestVersion?g=com.redi.spreadtrader.api&a=spreadtrader-api&repos=libs-release-local" && echo && echo'
alias latestrefdata='curl "http://artifactory.rdti.com/artifactory/api/search/latestVersion?g=com.redi.core.refdata&a=refdataMaster&repos=bins-release-local" && echo && echo'
alias latestAll='echo OMS: && latestoms && echo PRESENTATION: && latestpresentation && echo API: && lateststapi && echo PLATFORM: && latestplatform && echo REFDATA: && latestrefdata'

export JAVA_HOME=/opt/java/jdk1.8.0_92
export JRE_HOME=/opt/java/jdk1.8.0_92/jre
export PATH=$PATH:$JAVA_HOME:$JRE_HOME

alias grep='grep --color -E'
alias egrep='egrep --color'
alias fgrep='fgrep --color=auto'
alias fsrc='find . -type f \( -name "*.h" -o -name "*.H" -o -name "*.cpp" -o -name "*.c" -o -name "*.hxx" -o -name "*.cxx" -o -name "*.hpp" -o -name "*.inl" -o -name "*.C" -o -name "*.gradle" -o -name "*.groovy" \) | fgrep -v .svn | fgrep -v linux5_64 | xargs fgrep $*'
alias diskspace="du -s | sort -n -r |more"
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias h='history'
alias j='jobs -l'
alias c='clear'
alias ll='ls -alrt --color=auto --group-directories-first'
alias ..='cd ..'
alias xclip='xclip -selection c'

alias cdp='cd /home/wassere/workspace/rediplus-rt/trunk/reditech/possrv; ls -alrt'
alias startpos='/var/redi/runtime/possrv/avga-Primary/scripts/start_possrv.ksh'
alias stoppos='/var/redi/runtime/possrv/avga-Primary/scripts/stop_possrv.ksh'
alias bouncepos='stoppos && startpos'
alias makej='make -j$((1 + `grep -c processor /proc/cpuinfo`)) || make -j1'

alias gits="git branch && echo && git status"
alias svnst='svn st | grep -v ?'
alias cleanGradle="rm -rf ${GRADLE_REPOSITORY} ; rm -rf ~/.gradle/caches > /dev/null 2>&1"
alias cleanBuildDirs='find . -type d -name codegen -exec rm -rf {} + && find . -type d -name build -exec rm -rf {} +'
alias buildServerPlugin='cd /home/wassere/workspace/rediplus-rt/trunk/gradle; gradle clean; gradle; cd -'
alias makeGradleConfig='echo "version=LATEST-SNAPSHOT" > gradle.properties; svn add gradle.properties; echo "rootProject.name=\"`pwd | rev | cut -d/ -f1 | rev`\"" > settings.gradle; svn add settings.gradle'

alias _print_chef_versions='cat metadata.rb | grep "name\|version" | grep -v long_description | tr -d " " | sed s/name//g | sed s/version//g && echo'
alias updatechef='cd ~/workspace && grep -ir "defaultbundle\|use_snapshot_bundles" cb*/* | grep -v LATEST | grep [0-9].*[0-9].*[0-9].* && grep -r "use_snapshot_bundles ?" cb-redi-refdata-master-deployment | grep [0-9].*[0-9].*[0-9].* && printf "\n" && cd cb-redi-spreadtrader-client && git up > /dev/null 2>&1 && _print_chef_versions && cd - > /dev/null 2>&1 && cd cb-redi-oms-stream && git up > /dev/null 2>&1 && _print_chef_versions && cd - > /dev/null 2>&1 && cd cb-redi-platform-deployment && git up > /dev/null 2>&1 && _print_chef_versions && cd - > /dev/null 2>&1 && cd cb-redi-platform-tools && git up > /dev/null 2>&1 && _print_chef_versions && cd - > /dev/null 2>&1 && cd cb-redi-refdata-master-deployment && git up > /dev/null 2>&1 && _print_chef_versions && cd - > /dev/null 2>&1 && printf "\n"'

alias sshawesome='ssh wassere@nydevl0007'
alias omsstreamdev="ssh -t wassere@s2abcd0048 'less +F /var/redi/runtime/OM01/stream-listener/logs/messages.log'"
alias liststashdev="ssh -t wassere@s2bbcd0026 'ls -alrt /var/redi/runtime/OM01/stash/archives | grep messages | tail -5'"
alias omsstreamdevspin="ssh -t wassere@s2bbcd0026 'cd /var/redi/runtime/oms-stream/ ; bash'"
alias omsstreamqa="ssh -t wassere@scscom108 'less +F /var/redi/runtime/OM01/stream-listener/logs/messages.log'"
alias liststashqa="ssh -t wassere@scscom101 'ls -alrt /var/redi/runtime/OM01/stash/archives | grep messages | tail -5'"
alias omsstreamqaspin="ssh -t wassere@scscom101 'cd /var/redi/runtime/oms-stream/ ; bash'"
alias omsstreamprod="ssh -t wassere@s2abcp0088 'less +F /var/redi/runtime/OM01/stream-listener/logs/messages.log'"
alias liststashprod="ssh -t wassere@s2abcp0041 'ls -alrt /var/redi/runtime/OM01/stash/archives | grep messages | tail -5'"
alias commanderdev="ssh -t wassere@s2abcd0046 'cd /var/redi/runtime/oms-stream/OMS01-commander ; grep sending messages.log'"
alias commanderqa="ssh -t wassere@chscom104 'cd /var/redi/runtime/OM01/commander/logs ; grep sending messages.log'"
alias commanderprod="ssh -t wassere@s2abcp0079 'cd /var/redi/runtime/oms-stream/OMS01-commander ; grep sending messages.log'"
alias sequencerprod="ssh -t wassere@s2abcp0026 'echo /SEQUENCER/status | nc 127.0.0.1 1500'"
alias drawDecisionEngine='rm -rf digraph.dot decisionEngine.svg && python createNodeGraph.py && dot -Tsvg digraph.dot -o decisionEngine.svg'
alias drawTopology='python createTopologyGraph.py && ccomps -x digraph.dot | dot | gvpack -array1 | neato -Tjpg -n2 -o topology.jpg'
alias checkrefdatadev="ssh -t wassere@s2bbcd0026 '/var/redi/runtime/redi-refdata-master-deployment/primary/scripts/checkRefData.sh'"
alias checkrefdataqa="ssh -t wassere@chscom101 '/var/redi/runtime/redi-refdata-master-deployment/primary/scripts/checkRefData.sh'"
alias checkrefdataprod="ssh -t wassere@s2abcp0041 '/var/redi/runtime/redi-refdata-master-deployment/primary/scripts/checkRefData.sh'"

alias omsdevtop='cd ~/workspace/jumpserver/jump-server-dev && git co master && git up && echo && find ~/workspace/jumpserver/jump-server-dev/hosts -maxdepth 5 -mindepth 5 | cut -d"/" -f10,11,12'
alias omsqatop='cd ~/workspace/jumpserver/jump-server-qa && git co master && git up && echo && find ~/workspace/jumpserver/jump-server-qa/hosts -maxdepth 5 -mindepth 5 | xargs grep -r "-release" | tr -s " " | cut -d"/" -f10,11,12,23'
alias omsprodtop='cd ~/workspace/jumpserver/jump-server-prod && git co master && git up && echo && find ~/workspace/jumpserver/jump-server-prod/hosts -maxdepth 5 -mindepth 5 | xargs grep -r "-release" | tr -s " " | cut -d"/" -f10,11,12,23'

alias omsdevprop='cd ~/workspace/jumpserver/jump-server-dev && grep -r setProperty * | grep -v maxInFlight | cut -d":" -f2-99 | sort'
alias omsqaprop='cd ~/workspace/jumpserver/jump-server-qa && grep -r setProperty * | grep -v maxInFlight | cut -d":" -f2-99 | sort'
alias omsprodprop='cd ~/workspace/jumpserver/jump-server-prod && grep -r setProperty * | grep -v maxInFlight | cut -d":" -f2-99 | sort'

omsdevport() {
        omsdevtop | grep $1 && echo && echo "PORT:" && dfind $1\* app* | xargs grep textAdmin | tr -s " " | cut -d" " -f 3 | sort | uniq && cd - > /dev/null
}

omsqaport() {
        omsqatop | grep $1 && echo && echo "PORT:" && dfind $1\* app* | xargs grep textAdmin | tr -s " " | cut -d" " -f 3 | sort | uniq && cd - > /dev/null
}

omsprodport() {
        omsprodtop | grep $1 && echo && echo "PORT:" && dfind $1\* app* | xargs grep textAdmin | tr -s " " | cut -d" " -f 3 | sort | uniq && cd - > /dev/null
}


omsCopyVersions() {
	project="omsStream"

	if [ "$1" == "presentation" ] ; then
                project="spreadtrader-presentation"
        fi

	cd ~/workspace/jumpserver/jump-server-qa
	git co master
	git up
	
	cd ~/workspace/jumpserver/jump-server-prod
	#git co master
	#git up
	
	for componentAndVersion in `find ~/workspace/jumpserver/jump-server-qa/hosts -maxdepth 5 -mindepth 5 | xargs grep -r "$project""-.*-release" | tr -s " " | cut -d"/" -f12,23,24`
	do
		component=`echo $componentAndVersion | cut -f1 -d"/"`
		version=`echo $componentAndVersion | cut -f2 -d"/"`
		
		if [[ $version =~ ^[0-9] ]] ; then
			version=$version
		else
			version=`echo $componentAndVersion | cut -f3 -d"/"`
		fi

		echo "Updating $component to version $version"
		updateAppVersion $component $version
		
	done
}

gitrelease(){
	branchName=$1
	commitMessage=$branchName
	
	if [ "$branchName" == "" ] ; then
                echo "Enter a branch name for the release"
                return
        fi

	echo "1. Commit"
	git checkout -b $branchName
	
	echo
	echo "2. Push branch to origin"
	git push -u origin $branchName

	if [ "$2" != "" ] ; then
                commitMessage=$2
        fi
	
	echo "branch name = $branchName"
	echo "commit message = $commitMessage"

	echo
	echo "3. Commit - *remember to push*"
	git commit -am "$commitMessage"
	echo

	directory=`basename $PWD`

	if [ "$directory" == "omsStream" ] ; then
                google-chrome "https://github.com/REDIGlobal/dev-oms"
                return
        fi
	if [ "$directory" == "jump-server-dev" ] ; then
                google-chrome "https://github.com/REDIGlobal/jump-server-dev"
                return
        fi
	if [ "$directory" == "jump-server-qa" ] ; then
                google-chrome "https://github.com/REDIGlobal/jump-server-qa"
                return
        fi
	if [ "$directory" == "jump-server-prod" ] ; then
                google-chrome "https://github.com/REDIGlobal/jump-server-prod"
                return
        fi
}

gitcmp() {
	google-chrome "https://github.com/REDIGlobal/dev-oms/compare/release-$1...release-$2?expand=1"
}

checkmdentitlement() {
	username=$1
	symbol=$2
	
	if [ "$username" == "" ] ; then
                echo "Enter a user name for whom to check md entitlements"
                return
        fi

	if [ "$symbol" == "" ] ; then
                echo "Enter a symbol for which to check md entitlements"
                return
        fi

	google-chrome "http://c1bbcp1029.rdti.com/cgi-bin/cs/mdcheck.cgi?user=$username&symbol=$symbol"
}

finance() {
	google-chrome "http://finance.yahoo.com/quote/$1?p=$1"
}

stashdev() {
	if [ "$1" == "" ] ; then
                liststashdev
                return
        fi

	scp wassere@s2bbcd0026:/var/redi/runtime/OM01/stash/archives/$1 /home/eric/omsstash/$1
}

stashqa() {
	if [ "$1" == "" ] ; then
                liststashqa
                return
        fi

	scp wassere@scscom101:/var/redi/runtime/OM01/stash/archives/$1 /home/eric/omsstash/$1
}

stashprod() {
	if [ "$1" == "" ] ; then
                liststashprod
                return
        fi

	scp wassere@s2abcp0041:/var/redi/runtime/OM01/stash/archives/$1 /home/eric/omsstash/$1
}

omsdevstartcomponents(){
	nodes=( s2abcd0026 s2abcd0041 s2abcd0046 s2abcd0047 s2abcd0048 s2bbcd0026 s2bbcd0041 s2bbcd0046 s2bbcd0047 s2bbcd0048 s2bbcd0049 )
	
	pids=()
	for node in ${nodes[@]}
	do
		ssh -q wassere@$node 'find /var/redi/runtime/oms-stream -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_web -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_ignite -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_server_agents -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform-tools -name start_instance.ksh -exec sudo su rapp {} \;' &
		pids[${#pids[@]}]=$!;
	done

	# wait for job completion
        for pid in ${pids[*]}
        do
                wait $pid
        done
	echo
	echo "Setting PRIMARY components to active.."
	sleep 5
	echo "Almost there.."
	sleep 5
	echo "COMMANDER/sendCommand CRITICAL=true COMMAND=setActive DISCOVERY-ID=activatable_component tokenizedParameters=\"ACTIVE=false PRIMARY=true\"" | nc s2abcd0046 1505
}


omsqaversions(){
	nodes=( c1abct0088 chscom100 chscom101 chscom102 chscom103 chscom104 chscom105 chscom106 chscom107 scscom108 scscom100 scscom101 scscom102 scscom103 scscom104 scscom105 scscom106 scscom107 )

	echo "**************************"
	echo "** QA OMS node versions **"
	echo

        for node in ${nodes[@]}
        do
                echo "$node :"
		ssh -t -q wassere@$node 'ls -rt /var/chef/cache | grep omsStream | grep -v LATEST | tail -1'
		echo
        done
}

omsqaupdate(){
        cd ~/workspace/chef-repo
        echo "QA ROLE NODE UPDATE"
        echo
	
	git pull 
	echo

	omsVersion=$1
	clientVersion=$2

	if [ "$omsVersion" == "" ] ; then
		echo 'USAGE: omsqaupdate <oms_version> <client_version_or_X> [list_of_nodes_or_blank]'
		return
	fi

	if [ -z "$USERNAME" ]; then export USERNAME=$USER; fi
	if [ "$USERNAME" == "" ] ; then
		echo "I dont know who you are anymore. Please export your USERNAME"
		return
	fi

	if [ "$JENKINS_API_TOKEN" == "" ] ; then
		echo "First go to http://jenkins.rdti.com/user/$USERNAME/configure and click 'Show API Token...'. Then come back and run 'export JENKINS_API_TOKEN=<your token>'."
                return
	fi

	nodes=( c1abct0088 chscom100 chscom101 chscom102 chscom103 chscom104 chscom105 chscom106 chscom107 scscom108 scscom100 scscom101 scscom102 scscom103 scscom104 scscom105 scscom106 scscom107 )

	if [ "$3" != "" ] ; then
		shift 2
		nodes=( "$@" )
	fi
	
	filesToKnife=""

        echo "oms nodes:"
        for node in ${nodes[@]}
        do
                echo "Updating $node to cookbook version $omsVersion"
		fileName=roles/nodes/qa/$node.json
		filesToKnife=$filesToKnife" "$fileName
                sed -i "s/redi-oms-stream@.*\]/redi-oms-stream@$omsVersion]/" $fileName
                sed -i "s/redi-oms-stream::installSupport@.*\]/redi-oms-stream::installSupport@$omsVersion]/" $fileName
                sed -i "s/redi-oms-stream::installSpinsight@.*\]/redi-oms-stream::installSpinsight@$omsVersion]/" $fileName
        done

	commitMessage="Releasing omsStream with cookbook version $omsVersion"

        if [ "$clientVersion" != "" ] && [ "$clientVersion" != "X" ] ; then
                uinodes=( c1bbct0088 c1bbct0089 scscom109 scscom111 )
		
		echo
                echo "middle-tier and UI nodes:"
                for node in ${uinodes[@]}
                do
                        echo "Updating $node to cookbook version $clientVersion"
			fileName=roles/nodes/qa/$node.json
			filesToKnife=$filesToKnife" "$fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_ignite@.*\]/redi-spreadtrader-client::spreadtrader_ignite@$clientVersion]/" $fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_web@.*\]/redi-spreadtrader-client::spreadtrader_web@$clientVersion]/" $fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_server_agents@.*\]/redi-spreadtrader-client::spreadtrader_server_agents@$clientVersion]/" $fileName
                done
		commitMessage=$commitMessage" and client version $clientVersion"
        fi

	echo
	read -r -p "Confirming will run Jenkins upload, git commit and push, and knife! Are you sure? [y/N] " response
	response=${response,,}    # tolower
	if [[ $response =~ ^(yes|y)$ ]]
	then
		echo "Running chef.updoad.gf-qa Jenkins job.."
		curl --user wassere:$JENKINS_API_TOKEN http://jenkins.rdti.com/job/chef.upload.gf-qa/build --data-urlencode json="{\"parameter\": [{\"name\":\"cookbookArgs\", \"value\":\"redi-oms-stream $omsVersion\"}]}"
		if [ "$clientVersion" != "" ] && [ "$clientVersion" != "X" ] ; then
			curl --user wassere:$JENKINS_API_TOKEN http://jenkins.rdti.com/job/chef.upload.gf-qa/build --data-urlencode json="{\"parameter\": [{\"name\":\"cookbookArgs\", \"value\":\"redi-spreadtrader-client $clientVersion\"}]}"
		fi
		echo	
	
		echo
		echo "Checking into GIT:"
		git add -A	
		git commit -m "$commitMessage"
		git push origin master
		echo

		echo "Knifing:"
		#echo "ssh -t wassere@chef-workstation.rdti.com \"cd ~/chef-repo && git pull && source gf-qa.sh && knife role from file roles/_redi-platform-*qa* roles/redi-platform* && knife role from file $filesToKnife\""
		ssh -t wassere@chef-workstation.rdti.com "cd ~/chef-repo && git pull && source gf-qa.sh && knife role from file roles/_redi-platform-*qa* roles/redi-platform* && knife role from file $filesToKnife"

		echo
		echo "* DONT FORGET TO CONVERGE *"
	fi

	echo
	read -r -p "Confirming will begin converging the nodes! Are you sure? [y/N] " response
	response=${response,,}    # tolower
	if [[ $response =~ ^(yes|y)$ ]]
	then
		#echo Stopping session..
        	#echo "/SEQUENCER/stopSession" | nc chscom100 1500
	        #sleep 5000
        	#echo

		pids=()
		for node in ${nodes[@]} ${uinodes[@]}
		do
			# Kill all the stream processes for this node			
			ssh -q wassere@$node 'find /var/redi/runtime/oms-stream -name kill_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform -name kill_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_web -name kill_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_ignite -name kill_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_server_agents -name kill_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform-tools -name kill_instance.ksh -exec sudo su rapp {} \;' &
			pids[${#pids[@]}]=$!;
		done

		# wait for job completion
		for pid in ${pids[*]}
		do
		        wait $pid
		done

		for node in ${nodes[@]} ${uinodes[@]}
                do
                        # Kick off a converge for this node using Jenkins
                        echo
                        echo "curl --user $USERNAME:$JENKINS_API_TOKEN http://jenkins.rdti.com/view/Core%202.0/job/chef.converge.$node/build --data-urlencode json=\"\""
                        curl --user $USERNAME:$JENKINS_API_TOKEN http://jenkins.rdti.com/view/Core%202.0/job/chef.converge.$node/build --data-urlencode json=""
                done
	fi

	echo
	echo "** Wait for converges to complete -- then run omsqastartcomponents **"
	echo "See: http://jenkins.rdti.com/view/Core%202.0/"
}

omsqastartcomponents(){
	nodes=( c1abct0088 chscom100 chscom101 chscom102 chscom103 chscom104 chscom105 chscom106 chscom107 scscom108 scscom100 scscom101 scscom102 scscom103 scscom104 scscom105 scscom106 scscom107 )

	pids=()
	for node in ${nodes[@]}
	do
		ssh -q wassere@$node 'find /var/redi/runtime/oms-stream -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_web -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_ignite -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/spreadtrader_server_agents -name start_instance.ksh -exec sudo su rapp {} \; && find /var/redi/runtime/platform-tools -name start_instance.ksh -exec sudo su rapp {} \;' &
		pids[${#pids[@]}]=$!;
	done

	# wait for job completion
        for pid in ${pids[*]}
        do
                wait $pid
        done
	echo
	echo "Setting PRIMARY components to active"
	sleep 5
	echo "Almost there.."
	sleep 5
	echo "COMMANDER/sendCommand CRITICAL=true COMMAND=setActive DISCOVERY-ID=activatable_component ACTIVE=false PRIMARY=true" | nc chscom104 1505
}

omsprodversions(){
	nodes=( c1abcp0026 c1abcp0041 c1abcp0048 c1abcp0049 c1abcp0079 c1abcp0080 c1abcp0081 c1abcp0082 c1abcp0088 c1abcp1088 c1abcp0089 c1bbcp0026 c1bbcp0041 c1bbcp0048 c1bbcp0049 c1bbcp0079 c1bbcp0080 c1bbcp0081 c1bbcp0082 c1bbcp0088 c1bbcp1088 c1bbcp0089 s2abcp0026 s2abcp0041 s2abcp0048 s2abcp0049 s2abcp0079 s2abcp0080 s2abcp0081 s2abcp0082 s2abcp0088 s2abcp1088 s2abcp0089 s2bbcp0026 s2bbcp0041 s2bbcp0048 s2bbcp0049 s2bbcp0079 s2bbcp0080 s2bbcp0081 s2bbcp0082 s2bbcp0088 s2bbcp1088 s2bbcp0089 )

	echo "****************************"
	echo "** PROD OMS node versions **"
	echo

        for node in ${nodes[@]}
        do
                echo "$node :"
		ssh -t -q wassere@$node 'ls -rt /var/chef/cache | grep omsStream | grep -v LATEST | tail -1'
		echo
        done
}

omsprodupdate(){
        cd ~/workspace/chef-repo
        echo "PROD ROLE NODE UPDATE"
        echo

	git pull
	echo

	omsVersion=$1
	clientVersion=$2

	if [ "$omsVersion" == "" ] ; then
                echo 'USAGE: omsprodupdate <oms_version> <client_version_or_X> [list_of_nodes_or_blank]'
                return
        fi

	if [ "$JENKINS_API_TOKEN" == "" ] ; then
                echo "First go to http://jenkins.rdti.com/user/$USERNAME/configure and click 'Show API Token...'. Then come back and run 'export JENKINS_API_TOKEN=<your token>'."
                return
        fi

	nodes=( c1abcp0026 c1abcp0041 c1abcp0048 c1abcp0049 c1abcp0079 c1abcp0080 c1abcp0081 c1abcp0082 c1abcp0088 c1abcp1088 c1abcp0089 c1bbcp0026 c1bbcp0041 c1bbcp0048 c1bbcp0049 c1bbcp0079 c1bbcp0080 c1bbcp0081 c1bbcp0082 c1bbcp0088 c1bbcp1088 c1bbcp0089 s2abcp0026 s2abcp0041 s2abcp0048 s2abcp0049 s2abcp0079 s2abcp0080 s2abcp0081 s2abcp0082 s2abcp0088 s2abcp1088 s2abcp0089 s2bbcp0026 s2bbcp0041 s2bbcp0048 s2bbcp0049 s2bbcp0079 s2bbcp0080 s2bbcp0081 s2bbcp0082 s2bbcp0088 s2bbcp1088 s2bbcp0089 )
	
	if [ "$3" != "" ] ; then
                shift 2
                nodes=( "$@" )
        fi

	filesToKnife=""

        echo "oms nodes:"
        for node in ${nodes[@]} 
        do
                echo "Updating $node to cookbook version $omsVersion"
		fileName=roles/nodes/prod/$node.json
		filesToKnife=$filesToKnife" "$fileName
                sed -i "s/redi-oms-stream@.*\]/redi-oms-stream@$omsVersion]/" $fileName
                sed -i "s/redi-oms-stream::installSupport@.*\]/redi-oms-stream::installSupport@$omsVersion]/" $fileName
                sed -i "s/redi-oms-stream::installSpinsight@.*\]/redi-oms-stream::installSpinsight@$omsVersion]/" $fileName
        done

	commitMessage="Releasing omsStream with cookbook version $omsVersion"
	
        if [ "$clientVersion" != "" ] && [ "$clientVersion" != "X" ] ; then
                uinodes=( s2abcp1088 s2abcp0089 s2bbcp1088 s2bbcp0089 c1abcp1088 c1abcp0089 c1bbcp1088 c1bbcp0089 s2azcp0006 s2bzcp0006 c1azcp0006 c1bzcp0006 )

                echo
                echo "middle-tier and UI nodes:"
                for node in ${uinodes[@]}
                do
                        echo "Updating $node to cookbook version $clientVersion"
			fileName=roles/nodes/prod/$node.json
			filesToKnife=$filesToKnife" "$fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_ignite@.*\]/redi-spreadtrader-client::spreadtrader_ignite@$clientVersion]/" $fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_web@.*\]/redi-spreadtrader-client::spreadtrader_web@$clientVersion]/" $fileName
                        sed -i "s/redi-spreadtrader-client::spreadtrader_server_agents@.*\]/redi-spreadtrader-client::spreadtrader_server_agents@$clientVersion]/" $fileName
                done
		commitMessage=$commitMessage" and client version $clientVersion"
        fi

	echo
        read -r -p "Confirming will run Jenkins upload, git commit and push, and knife! Are you sure? [y/N] " response
        response=${response,,}    # tolower
        if [[ $response =~ ^(yes|y)$ ]]
        then
        	echo "Running chef.updoad.gf-prod Jenkins job.."
		curl --user $USERNAME:$JENKINS_API_TOKEN http://jenkins.rdti.com/job/chef.upload.gf-prod/build --data-urlencode json="{\"parameter\": [{\"name\":\"cookbookArgs\", \"value\":\"redi-oms-stream $omsVersion\"}]}"
		if [ "$clientVersion" != "" ] && [ "$clientVersion" != "X" ] ; then
			curl --user $USERNAME:$JENKINS_API_TOKEN http://jenkins.rdti.com/job/chef.upload.gf-prod/build --data-urlencode json="{\"parameter\": [{\"name\":\"cookbookArgs\", \"value\":\"redi-spreadtrader-client $clientVersion\"}]}"
		fi
	        echo
	
		echo
		echo "Checking into GIT:"
		git add -A	
		git commit -am "$commitMessage"
	        git push origin master
	
		echo "Knifing:"
		#echo "ssh -t wassere@chef-workstation.rdti.com \"cd ~/chef-repo && git pull && source gf-prod.sh && knife role from file roles/_redi-platform-*prod* roles/redi-platform* && knife role from file $filesToKnife\""
		ssh -t wassere@chef-workstation.rdti.com "cd ~/chef-repo && git pull && source gf-prod.sh && knife role from file roles/_redi-platform-*prod* roles/redi-platform* && knife role from file $filesToKnife"
	
		echo
		echo "* DONT FORGET TO CONVERGE *"
	fi

	echo
	read -r -p "Confirming will begin converging the nodes! Are you sure? [y/N] " response
	response=${response,,}    # tolower
	if [[ $response =~ ^(yes|y)$ ]]
	then
		for node in ${nodes[@]} ${uinodes[@]}
		do
			ssh -qt wassere@$node 'find /var/redi/runtime/oms-stream -name kill_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/platform -name kill_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_web -name kill_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_ignite -name kill_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_server_agents -name kill_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/platform-tools -name kill_instance.ksh -exec sudo su rapp {} \;'
		done
		
		for node in ${nodes[@]} ${uinodes[@]}
		do
			ssh -qt wassere@$node 'sudo chef-client -l info' &
			pids[${i}]=$!;
		done

		# wait for all converges to complete
		for pid in ${pids[*]}
		do
			wait $pid
		done
		
		for node in ${nodes[@]} ${uinodes[@]}
		do
			ssh -qt wassere@$node 'find /var/redi/runtime/oms-stream -name start_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/platform -name start_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_web -name start_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_ignite -name start_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/spreadtrader_server_agents -name start_instance.ksh -exec sudo su rapp {} \;'		
			ssh -qt wassere@$node 'find /var/redi/runtime/platform-tools -name start_instance.ksh -exec sudo su rapp {} \;'
		done
	fi
}

cmd() {
	for i in $( ps -ef | grep java | cut -d' ' -f34 | cut -d= -f2 | grep -v '^$'); do
		ssh -t wassere@$1 "echo $2 | nc 127.0.0.1 $i"
        done
}

copySshKeyToHosts() {
   if [[ -f password.txt && -f list_of_hosts.txt ]]; then
       for node in `cat list_of_hosts`; do
         echo "COPYING SSH KEY to $node" 
         sshpass -f password.txt ssh-copy-id -f -o StrictHostKeyChecking=no $node
       done 
   else
       echo "To use this, you must create 2 files. 'passwords.txt' containing your password, and 'list_of_hosts.txt' containing a newline seperated list of remote hosts to copy your ssh key to"
       echo
   fi
 }

export ALTERNATE_EDITOR=""
export EDITOR=vim
export HISTFILESIZE=3000

update() {
	PREV_BRANCH=`git branch | grep \* | cut -d' ' -f2`	
	git co `echo $1 | cut -d/ -f2`
	git up
	git co $PREV_BRANCH
}
	

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

dfind() {
	find -name $1 -exec find {} -name $2 \; | uniq
}

updateAppVersion() {
	version="${@: -1}"

	length=$(($#-1))
	args=${@:1:$length}

	for component in $args
	do
		dfind $component app* | xargs sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+/$version/g"
	done
}

updateAppVersionA() {
        version="${@: -1}"

        length=$(($#-1))
        args=${@:1:$length}

        for component in $args
        do
                dfind $component app* | grep s2a\|c1a | xargs sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+/$version/g"
        done
}

updateAppVersionB() {
        version="${@: -1}"

        length=$(($#-1))
        args=${@:1:$length}

        for component in $args
        do
                dfind $component app* | grep s2b\|c1b | xargs sed -i "s/[0-9]\+\.[0-9]\+\.[0-9]\+/$version/g"
        done
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

macRec () {
	sleep 0.3s
	cnee --record -o /tmp/cnee_$1.xns --events-to-record 10000 --keyboard  --stop-key Shift_R
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
