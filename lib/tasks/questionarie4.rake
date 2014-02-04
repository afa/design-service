# coding: utf-8
namespace :questionarie do
	desc "Add 4 ankete"
	task :init4 => :environment do
		questionnaire = Questionnaire.new(:name => "Строительные бригады", :specialization_id => 6, :is_numeric => false)

	  	questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
	  		:questionnaire_field_id => 1,
	  		:value => 'Фамилия',
	  		:position => 1,
	  		:location => 'left',
	  		:is_necessarily => false,
	  		:kind => 'last_name'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Имя',
		  		:position => 2,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'first_name'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Отчество',
		  		:position => 3,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'patronymic'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'E-mail',
		  		:position => 5,
		  		:location => 'right',
		  		:is_necessarily => false,
		  		:kind => 'email'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Тел.моб.',
		  		:position => 6,
		  		:location => 'right',
		  		:is_necessarily => false,
		  		:kind => 'phone'
		  	)
		
		

		question1 = Question.new(
			:position => 1,
			:name => 'Профессиональный опыт',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_values',
			:is_necessarily => false,
			:value => 'Перечень выполняемых работ'
		)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question1

		question11 = Question.new(
			:position => 2,
			:name => '',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_values',
			:is_necessarily => false,
			:value => 'Названия объектов, в разработке которых Вы принимали участие'
		)
		question11.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question11.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question11.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question11

		question2 = Question.new(
			:position => 3,
			:name => 'Прикрепите Ваши портфолио с описанием файлов (Вы можете прикрепить заархивированные файлы)',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_files',
			:is_necessarily => false,
			:value => ''
		)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question2

		

		questionnaire.save
	end
end