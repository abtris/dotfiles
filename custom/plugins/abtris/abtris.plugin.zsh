cs() { cd ~/Sites/$1; }
_cs() { _files -W ~/Sites -/; }
compdef _cs cs

cz() { cd ~/zend-ws/$1; }
_cz() { _files -W ~/zend-ws -/; }
compdef _cz cz