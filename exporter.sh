url=$1
secret=$2
checksum=$(echo -n "getMeetings$secret" | sha1sum | awk '{print $1}')
echo $checksum
NumberParticipant_api=$(curl https://$url/bigbluebutton/api/getMeetings?checksum=$checksum -s | grep  participantCount | grep -oE '[0-9]+')                                                                                                
NumberParticipantVoice_api=$(curl https://$url/bigbluebutton/api/getMeetings?checksum=$checksum -s | grep  voiceParticipantCount | grep -oE '[0-9]+')                                                                                      
NumberParticipantVideo_api=$(curl https://$url/bigbluebutton/api/getMeetings?checksum=$checksum -s | grep  videoCount | grep -oE '[0-9]+')                                                                                                 
NumberParticipantlistener_api=$(curl https://$url/bigbluebutton/api/getMeetings?checksum=$checksum -s | grep  listenerCount | grep -oE '[0-9]+')                                                                                           
NumberOfRoom=$(curl https://$url/bigbluebutton/api/getMeetings?checksum=$checksum -s | grep meetingName | wc -l)
NumberParticipantVoice=0
NumberParticipantVideo=0
NumberParticipantlistener=0
NumberParticipant=0



for each in $NumberParticipantVoice_api;
do
        NumberParticipantVoice=$((NumberParticipantVoice+each))
done
for each in $NumberParticipant_api;
do
        NumberParticipant=$((NumberParticipant+each))
done
for each in $NumberParticipantVideo_api;
do
        NumberParticipantVideo=$((NumberParticipantVideo+each))
done
for each in $NumberParticipantlistener_api;
do
        NumberParticipantlistener=$((NumberParticipantlistener+each))
done

echo -e "HTTP/1.0 200 OK\r\n\r\nbbb_number_of_participant $NumberParticipant\nbbb_number_of_participant_voice $NumberParticipantVoice\nbbb_number_of_participant_video $NumberParticipantVideo\nbbb_number_of_participant_listener $NumberParticipantlistener\nbbb_number_of_room $NumberOfRoom"
