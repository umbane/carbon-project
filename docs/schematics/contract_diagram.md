``` mermaid

%%{
  init: {
    'theme': 'base',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#fff',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%

classDiagram
    class CarbonCredits {
        -totalRegistered : uint
        -verifiercount : uint
        -customercount : uint
        +registerCreditHolder()
        +registerVerifiers()
        +registerCustomer()
        +getVerifiers()
        +getCreditHoilders()
        +getCustomerProfile()
    }

    class CreditToken {
        -totalsupply : uint
        -supply : uint
        -tokenBurnedCount : uint
        +approveCreditsHeld()
        +createCarbonToken()
        +transferCredits()
        +transferCreditsFrom()
        +approveBurn()
        +burnTokens()
        +buyCarbonCredits()
    }

    class Certification {
        -_name : string
        -_symbol : string
        +addBurnedTokens()
        +mint()
        +_addNFToken()
    }

    class Token {
        -mJTotalSupply : uint256
        -aCTotalSupply : uint256
        +mintMJ()
        +mintAC()
        +burnMJ()
        +burnAC()
        +getMJBalance()
        +getACBalance()
        +requestEnergyData()
        +fulfillRandomWords()
    }

    class IntegrationContract {
        +accrueAC()
        +processMJForAC()
        +carbonCreditGatewayAPI()
    }

    CarbonCredits <|-- CreditToken : inheritance
    CreditToken <|-- Certification : inheritance
    CreditToken -- Token : uses
    IntegrationContract -- CarbonCredits : uses
    IntegrationContract -- CreditToken : uses
    IntegrationContract -- Token : uses

    Note right of Token : "Uses Chainlink Oracle"

```
