pragma solidity >=0.4.0 <0.9.0;

contract MyFirstToken {
    
    string _name = "MyFirstToken";
    string _symbol = "MFT";
    uint8 _decimals = 18;
    uint256 _totalSupply;
    
    address _verifiacc = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    constructor(uint256 total) public {
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;
    }
    
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint) {
        return _decimals;
    }
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }


    function mint(address account, uint256 amount) public {
        require(account == _verifiacc);
        require(_totalSupply + amount >= _totalSupply && balances[account] + amount >= balances[account]);
        balances[account] += amount;
        _totalSupply += amount;
    }
    
    function burn(uint256 amount) public {
        require(_totalSupply + amount >= _totalSupply && balances[msg.sender] + amount >= balances[msg.sender]);
        _totalSupply -= amount;
        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, msg.sender, amount);
        
        require(balances[msg.sender] >= amount);
        unchecked {
            balances[msg.sender] -= amount;
        }
            _totalSupply -= amount;
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
