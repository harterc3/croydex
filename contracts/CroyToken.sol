// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract CroyToken {

  string public name = "MyERC20Token";
  string public symbol = "MET";
  uint8 public decimals = 18;

  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
  event Transfer(address indexed from, address indexed to, uint tokens);

  mapping(address => uint256) private _balances;
  mapping(address => mapping (address => uint256)) private _allowed;
  uint256 private _totalSupply;

  constructor(string memory tknName, string memory tknSymbol, uint256 tknTotal, uint8 tknDecimals) {
    name = tknName;
    symbol = tknSymbol;
    _totalSupply = tknTotal;
    decimals = tknDecimals;
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address tokenOwner) public view returns (uint) {
    return _balances[tokenOwner];
  }

  function allowance(address tokenOwner, address spender) public view returns (uint) {
    return _allowed[tokenOwner][spender];
  }

  function transfer(address to, uint tokens) public returns (bool) {
    require(_balances[msg.sender] >= tokens);
    _balances[msg.sender] = _balances[msg.sender] - tokens;
    _balances[to] = _balances[to] + tokens;
    emit Transfer(msg.sender, to, tokens);
    return true;
  }

  function approve(address spender, uint tokens)  public returns (bool) {
    _allowed[msg.sender][spender] = tokens;
    emit Approval(msg.sender, spender, tokens);
    return true;
  }

  function transferFrom(address from, address to, uint tokens) public returns (bool) {
    require(_balances[from] >= tokens);
    require(_allowed[from][msg.sender] >= tokens);
    _balances[from] = _balances[from] - tokens;
    _allowed[from][msg.sender] = _allowed[from][msg.sender] - tokens;
    _balances[to] = _balances[to] + tokens;
    emit Transfer(from, to, tokens);
    return true;
  }
}