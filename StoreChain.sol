// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract Mystore {
    IERC20 public store;
    address public owner;
    uint256 public TokenPrice = 10;

    event TokenSale(address customer, uint256 jumlah);

    constructor(address _alamatToken) {
        store = IERC20(_alamatToken);
        owner = msg.sender;

    }

    function TokenBuy() public payable  {
        uint256 jumlahToken = msg.value * TokenPrice;
        uint256 stok = store.balanceOf(address(this));
        require(stok >= jumlahToken, "maaf, Stok Kosong");

       bool sukses = store.transfer(msg.sender, jumlahToken);
       require(sukses, "Transfer token gagal");
       emit TokenSale(msg.sender, jumlahToken);
    }

    function Admin() public {
        require(msg.sender == owner, "Hanya Bisa Ditarik Oleh super Admin");
        payable(owner).transfer(address(this).balance);
    }
}