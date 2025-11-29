// SPDX-License-Identifier: MIT
pragma solidity >=0.8.30 <0.9.0;


contract SimpanData {

    // State Variable: Disimpan permanen di blockchain (memakan biaya gas)
    uint256 public angkaFavorit; 

    // Function untuk mengubah data (Write)
    // 'public' berarti bisa dipanggil oleh siapa saja (user atau contract lain)
    function simpan(uint256 _angka) public {
        angkaFavorit = _angka;
    }

    // Function untuk membaca data (Read)
    // 'view' berarti hanya membaca state tanpa mengubahnya (gratis/tanpa gas)
    // 'returns' menentukan tipe data yang dikembalikan
    function ambil() public view returns (uint256) {
        return angkaFavorit;
    }
}