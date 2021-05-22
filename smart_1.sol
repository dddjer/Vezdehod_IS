pragma solidity >=0.4.0 <0.9.0;

contract MyFirstToken {
    
    string name_;
    string symbol_;
    uint8 decimals_;
    uint256 totalSupply_;
    
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    
    function name() public view returns (string memory) {
        return name_;
    }
    function symbol() public view returns (string memory) {
        return symbol_;
    }
    function decimals() public view returns (uint) {
        return decimals_;
    }
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        require(_value <= balances[msg.sender] && balances[_to] + _value >= balances[_to]);
        balances[msg.sender] = balances[msg.sender] -_value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[_from] && balances[_to] + _value >= balances[_to] && allowed[_from][msg.sender] >= _value);
        balances[_from] = balances[_from] -_value;
        balances[_to] = balances[_to] + _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
