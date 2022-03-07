// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Diamond_Hands_Eth_Only {

  uint num_of_holds = 0;
  event print_num_of_holds(uint _num_of_holds);

  struct Hold_Struct {
    uint hold_id;
    address addy;
    uint seconds_to_hold;
    uint wei_stored;
    uint date_hold_created;
    address nft_contract_addres;
    uint nft_token_id;
    address erc_20_contract_address;
    uint erc_20_tokens_stored;
  }

  mapping(uint => Hold_Struct) holds;

  function make_eth_hold(uint _seconds_to_hold) public payable returns(uint) {
    Hold_Struct memory new_hold;
    new_hold.hold_id = num_of_holds;
    new_hold.addy = msg.sender;
    new_hold.seconds_to_hold = _seconds_to_hold;
    new_hold.date_hold_created = block.timestamp;
    new_hold.wei_stored = msg.value;
    num_of_holds += 1;
    return num_of_holds - 1;
  }

  function collect_hold(uint _hold_id) public {
    Hold_Struct memory hold = holds[_hold_id];
    payable(hold.addy).transfer(hold.wei_stored);
  }

  function show_num_of_holds() public returns(uint) {
      emit print_num_of_holds(num_of_holds);
      return num_of_holds;
  }

}