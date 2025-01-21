// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ERC20 {
    uint8 public decimals;
    uint256 public totalSupply;

    string public name;
    string public symbol;

    address public owner;

    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => uint256) public balanceOf;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event TokenMinted(address indexed _to, uint256 _amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;

        owner = msg.sender;
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[_to] += _amount;

        emit TokenMinted(_to, _amount);
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(_to != address(0), "cannot send to address(0)");
        require(balanceOf[msg.sender] >= _amount, "you aint rich enough");

        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function _allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return allowance[_owner][_spender];
    }

    function approve(address _spender, uint256 _amount) public returns (bool) {
        allowance[msg.sender][_spender] = _amount;

        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public returns (bool) {
        require(balanceOf[_from] >= _amount, "not enough money");

        if (msg.sender != _from) {
            require(
                allowance[_from][msg.sender] >= _amount,
                "not enough allowance"
            );

            allowance[_from][msg.sender] -= _amount;
        }

        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    }

    function _name() public view returns (string memory) {
        return name;
    }

    function _owner() public view returns (address) {
        return owner;
    }

    function _symbol() public view returns (string memory) {
        return symbol;
    }

    function _decimals() public view returns (uint8) {
        return decimals;
    }

    function _totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function _balanceOf(address _owner) public view returns (uint256) {
        return balanceOf[_owner];
    }
}
