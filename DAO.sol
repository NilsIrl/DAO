contract DAO is DAOInterface, Token, TokenCreation {
    /* ... */
    function getMyReward() noEther returns (bool _success) {
        // msg.sender is the caller. An instance of "Exploit" 
        return withdrawRewardFor(msg.sender);
    }

    function withdrawRewardFor(address _account) noEther internal returns (bool _success) {
        // Assume that initially
        // balanceOf(_account) == 100
        // paidOut[_account] == 0
        // rewardAccount.accumulatedInput() == 100
        // totalSupply == 200
        if ((balanceOf(_account) * rewardAccount.accumulatedInput()) / totalSupply < paidOut[_account])
            throw;

        uint reward =
            (balanceOf(_account) * rewardAccount.accumulatedInput()) / totalSupply - paidOut[_account];
        if (!rewardAccount.payOut(_account, reward))
            throw;
        paidOut[_account] += reward;
        return true;
    }
    /* ... */
}

