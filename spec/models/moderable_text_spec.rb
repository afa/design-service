require 'spec_helper'

describe ModerableText do
  
  When(:msg) { described_class.create( creation_params ) }
  context 'on creation' do
    context 'when original_text given' do
      Given(:creation_params) { {original_text: 'hihi'} }
      Then { msg.should have_failed }
    end
    context 'when moderated_text given' do
      Given(:creation_params) { {moderated_text: 'hoho'} }
      Then { msg.should have_failed }
    end
    context 'when verified given' do
      Given(:creation_params) { {text: 'hihi', verified: true} }
      Then { msg.should have_failed }
    end
    context 'when rejected given' do
      Given(:creation_params) { {text: 'hihi', rejected: false} }
      Then { msg.should have_failed }
    end
    
    context 'when text given' do
      Given(:creation_params) { {text: 'hihi'} }
      Then { msg.original_text.should == 'hihi' }
      Then { msg.moderated_text.should == 'hihi' }
      Then { msg.verified.should be_false }
      Then { msg.rejected.should be_false }
    end
    
    context 'when empty text given' do
      Given(:creation_params) { {text: ''} }
      Then { msg.should have_failed }
    end
  end
  
  context 'when it is already created' do
    Given(:creation_params) { {text: 'hihi'} }
    
    context 'when parameters updated with' do
      When(:updating) { msg.update_attributes(new_parameters) }  
      context 'original_text' do
        Given(:new_parameters) { {original_text: 'haha'} }
        Then { updating.should have_failed }
      end
      
      context 'moderated_text' do
        Given(:new_parameters) { {moderated_text: 'hoho'} }
        Then { updating.should have_failed }
      end
      context 'when verified given' do
        Given(:new_parameters) { {verified: false} }
        Then { updating.should have_failed }
      end
      context 'when rejected given' do
        Given(:new_parameters) { {rejected: false} }
        Then { updating.should have_failed }
      end

      
      context 'text' do
        Given(:new_parameters) { {text: 'hoho'} }
        Then { updating.should be_true }
        Then { msg.original_text.should == 'hihi' }
        Then { msg.moderated_text.should == 'hoho' }
        Then { msg.verified.should be_false }
        Then { msg.rejected.should be_false }
      end
      
      context 'when empty text' do
        Given(:new_parameters) { {text: ''} }
        Then { updating.should have_failed  }
      end
    end
    
    context 'and marked as' do
      context 'verified and not rejected' do
        When{ msg.verified = true }
        When{ msg.rejected = false }
        Then{ msg.verified.should be_true }
        Then{ msg.rejected.should be_false }
        Then{ msg.rejected.should be_accepted }
      end
      
      context 'not verified and not rejected' do
        When{ msg.verified = true }
        When{ msg.rejected = false }
        Then{ msg.verified.should be_true }
        Then{ msg.rejected.should be_false }
        Then{ msg.rejected.should_not be_accepted }
      end
      context 'not verified and rejected' do
        When{ msg.verified = false }
        When{ msg.rejected = true }
        Then{ msg.verified.should be_false }
        Then{ msg.rejected.should be_true }
        Then{ msg.rejected.should_not be_accepted }
      end
      context 'verified but rejected' do
        When{ msg.verified = true }
        When{ msg.rejected = true }
        Then{ msg.verified.should be_true }
        Then{ msg.rejected.should be_true }
        Then{ msg.rejected.should_not be_accepted }
      end
      
    end
  end

end
