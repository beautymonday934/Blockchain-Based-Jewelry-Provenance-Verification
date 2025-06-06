# Blockchain-Based Jewelry Provenance Verification

A comprehensive blockchain solution for tracking jewelry from gemstone origin through craftsmanship to final sale, with integrated insurance and authenticity guarantees.

## Overview

This system provides end-to-end traceability for jewelry pieces using smart contracts on the Stacks blockchain. It ensures transparency, authenticity, and trust in the jewelry supply chain.

## Features

### 🏪 Jeweler Verification
- Register and verify jewelry businesses
- License validation and status tracking
- Authorized jeweler directory

### 💎 Gemstone Tracking
- Track gemstone origins and mining locations
- Record gemstone characteristics (carat, color, clarity)
- Complete ownership history and transfer records

### 🔨 Craftsmanship Certification
- Create jewelry piece records
- Professional craftsmanship grading
- Quality certification with validity periods

### ✅ Authenticity Guarantee
- Issue authenticity guarantees for jewelry pieces
- Coverage amount and terms specification
- Guarantee validation and revocation

### 🛡️ Insurance Integration
- Create comprehensive insurance policies
- File and process insurance claims
- Policy management and validation

## Smart Contracts

### 1. Jeweler Verification Contract (\`jeweler-verification.clar\`)
Manages the registration and verification of jewelry businesses.

**Key Functions:**
- \`register-jeweler\`: Register a new jewelry business
- \`verify-jeweler\`: Verify a registered jeweler (admin only)
- \`get-jeweler\`: Retrieve jeweler information
- \`is-jeweler-verified\`: Check verification status

### 2. Gemstone Tracking Contract (\`gemstone-tracking.clar\`)
Tracks gemstones from origin through the supply chain.

**Key Functions:**
- \`register-gemstone\`: Register a new gemstone with origin details
- \`transfer-gemstone\`: Transfer gemstone ownership
- \`get-gemstone\`: Retrieve gemstone information
- \`get-transfer-history\`: View ownership transfer history

### 3. Craftsmanship Certification Contract (\`craftsmanship-certification.clar\`)
Manages jewelry piece creation and craftsmanship certification.

**Key Functions:**
- \`create-jewelry-piece\`: Create a new jewelry piece record
- \`certify-craftsmanship\`: Certify the quality of craftsmanship
- \`get-jewelry-piece\`: Retrieve jewelry piece information
- \`is-certification-valid\`: Check certification validity

### 4. Authenticity Guarantee Contract (\`authenticity-guarantee.clar\`)
Provides authenticity guarantees for jewelry pieces.

**Key Functions:**
- \`issue-guarantee\`: Issue an authenticity guarantee
- \`revoke-guarantee\`: Revoke an existing guarantee
- \`get-guarantee\`: Retrieve guarantee information
- \`is-guarantee-valid\`: Check guarantee validity

### 5. Insurance Integration Contract (\`insurance-integration.clar\`)
Manages insurance policies and claims for jewelry pieces.

**Key Functions:**
- \`create-policy\`: Create an insurance policy
- \`file-claim\`: File an insurance claim
- \`process-claim\`: Process and approve/deny claims
- \`is-policy-active\`: Check policy status

## Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd jewelry-provenance-verification
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### Deploying Contracts

Deploy the contracts in the following order to ensure proper dependencies:

1. \`jeweler-verification.clar\`
2. \`gemstone-tracking.clar\`
3. \`craftsmanship-certification.clar\`
4. \`authenticity-guarantee.clar\`
5. \`insurance-integration.clar\`

### Example Workflow

1. **Register Jeweler**: A jewelry business registers and gets verified
2. **Register Gemstone**: Mine or supplier registers gemstone with origin details
3. **Transfer to Jeweler**: Gemstone is transferred to verified jeweler
4. **Create Jewelry Piece**: Jeweler creates jewelry piece using gemstones
5. **Certify Craftsmanship**: Quality expert certifies the craftsmanship
6. **Issue Guarantee**: Guarantor provides authenticity guarantee
7. **Create Insurance**: Insurance company creates policy for the piece

## Testing

The project includes comprehensive tests for all contracts using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract function calls
- Error handling
- Data validation
- State management

## Security Considerations

- Only verified jewelers can create jewelry pieces
- Ownership validation for all transfers
- Time-based validation for guarantees and policies
- Access control for administrative functions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes 
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
