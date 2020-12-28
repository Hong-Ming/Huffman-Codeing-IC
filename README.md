# Huffman Codeing IC

## Table of Contents
- [Intorduction](#intorduction)
- [Directory Tree](#directory-tree)
- [Requirements](#requirements)
- [Contributor](#contributor)

## Intorduction
Implemented 8-bit Huffman coding algorithm using System Verilog. The system takes an image as an input, the image contains 100 pixels and each pixel value is an integer between 1 to 6 (inclusive). The system then outputs the Huffman Code for each pixel value based on the source probability distribution (more frequent pixel values will have the shorter codewords). This is the final project of the Digital Circuit and Systems class in NCTU.

## Directory Tree
<pre>
Huffman_Codeing_IC/
├─ huffman.sv ....... Main function for Huffman coding
├─ testbench.sv ..... RTL testbench
├─ pattern.sv ....... RTL testing pattern
├─ main.cpp ......... C++ function to compute Huffman coding (for generating testing pattern)
├─ input.txt ........ input image
└─ output.txt ....... output Huffman coding
</pre>

## Requirements
- **HDL**: [SystemVerilog](https://en.wikipedia.org/wiki/SystemVerilog)

## Contributor
- [Hong-Ming Chiu](https://hong-ming.github.io/)
- [Huan-Jung Lee]()