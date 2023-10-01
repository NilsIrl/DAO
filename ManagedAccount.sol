contract ManagedAccount is ManagedAccountInterface{
    /* ... */
    function payOut(address _recipient, uint _amount) returns (bool) {
        // Here msg.sender == address of caller, the "DAO" contract
        // msg.value == 0 && payOwnerOnly == false
        if (msg.sender != owner || msg.value > 0 || (payOwnerOnly && _recipient != owner))
            throw;
        if (_recipient.call.value(_amount)()) {
            // PayOut is a predefined event that can be listened to. This is
            // not relevant to the challenge.
            PayOut(_recipient, _amount);
            return true;
        } else {
            return false;
        }
    }
}
