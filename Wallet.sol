// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract wallet {
    mapping(address => uint256) public saldo;
    address public owner;

    // Struct untuk mencatat detail transaksi
    struct Transaksi {
        address user;
        uint256 jumlah;
        string tipe; // "Setor" atau "Tarik"
        uint256 waktu;
    }

    // Array untuk menyimpan daftar riwayat
    Transaksi[] public riwayat;

    event transfercome(address pengirim, uint256 jumlah);
    event Penarikan(address penerima, uint256 jumlah);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Kamu bukan Seorang Admin");
        _;
    }

    function SetorUang() public payable {
        saldo[msg.sender] += msg.value;

        // Catat ke riwayat (Tipe: "Setor")
        riwayat.push(Transaksi(msg.sender, msg.value, "Setor", block.timestamp));
        
        emit transfercome(msg.sender, msg.value);
    }

    function cekSaldoSaya() public view returns (uint256) {
        return saldo[msg.sender];
    }

    function tarikUang(uint256 jumlah) public {
        require(saldo[msg.sender] >= jumlah, "Saldo tidak cukup, Bos!");
        
        saldo[msg.sender] -= jumlah;
        
        payable(msg.sender).transfer(jumlah);
        
        // Catat ke riwayat (Tipe: "Tarik")
        // Perhatikan: Kita pakai 'jumlah', bukan 'msg.value'
        riwayat.push(Transaksi(msg.sender, jumlah, "Tarik", block.timestamp));

        emit Penarikan(msg.sender, jumlah);
    }

    function TakeAllMoney() public onlyOwner {
        uint256 totalIsiKontrak = address(this).balance;
        payable(owner).transfer(totalIsiKontrak); 
    }
}