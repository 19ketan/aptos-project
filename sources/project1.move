module MyModule::SimpleMove 
{
   use aptos_framework::signer;
   use aptos_framework::coin::{Self, Coin};
   use aptos_framework::aptos_coin::AptosCoin;

   struct SimpleData has store, key {
       balance: u64,
   }

   public fun create_account(user: &signer) {
       // Create a SimpleData resource for the user
       let simple_data = SimpleData { balance: 0 };
       move_to(user, simple_data);
   }

   public fun deposit(user: &signer, amount: u64) acquires SimpleData {
       // Withdraw the tokens from the user's account
       let coins = coin::withdraw<AptosCoin>(user, amount);

       // Get the user's SimpleData resource and update the balance
       let simple_data = borrow_global_mut<SimpleData>(signer::address_of(user));
       simple_data.balance = simple_data.balance + amount;

       // Deposit the coins back to the user's account
       coin::deposit<AptosCoin>(signer::address_of(user), coins);
   }
}