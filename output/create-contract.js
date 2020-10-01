const ethers = require("ethers");
const fs = require("fs");

const main = async () => {
  const file = process.argv[2];
  const data = JSON.parse(fs.readFileSync(file, "utf-8"));
  const recipients = Object.keys(data);

  console.log(`// SPDX-License-Identifier: MIT
// from file ${file}
pragma solidity ^0.6.7;

library ERC20SafeTransfer {
    function safeTransfer(address _tokenAddress, address _to, uint256 _value) internal returns (bool success) {
        // note: both of these could be replaced with manual mstore's to reduce cost if desired
        bytes memory msg = abi.encodeWithSignature("transfer(address,uint256)", _to, _value);
        uint msgSize = msg.length;

        assembly {
            // pre-set scratch space to all bits set
            mstore(0x00, 0xff)

            // note: this requires tangerine whistle compatible EVM
            if iszero(call(gas(), _tokenAddress, 0, add(msg, 0x20), msgSize, 0x00, 0x20)) { revert(0, 0) }
            
            switch mload(0x00)
            case 0xff {
                // token is not fully ERC20 compatible, didn't return anything, assume it was successful
                success := 1
            }
            case 0x01 {
                success := 1
            }
            case 0x00 {
                success := 0
            }
            default {
                // unexpected value, what could this be?
                revert(0, 0)
            }
        }
    }
}

interface ERC20 {
    function transfer(address _to, uint256 _value) external returns (bool success);
}

contract Reimbursement {
  mapping (address => uint256) public amounts;
  mapping (address => bool) public reimbursed;

  constructor() public {`);
  for (const r of recipients) {
    console.log(
      `    amounts[${ethers.utils.getAddress(r)}] = ${data[r].rawValue};`
    );
  }
  console.log(`
  }
  
  function claim(address _token) public {
    require(!reimbursed[msg.sender], "already reimbursed");
    require(amounts[msg.sender] > 0, "not claimable");
    require(ERC20(_token).transfer(msg.sender, amounts[msg.sender]));
    reimbursed[msg.sender] = true;
  }
  `);
  console.log("}");
};

main();