# coding: utf-8
namespace :questionarie do
	desc "Add 3 ankete"
	task :init3 => :environment do
		questionnaire = Questionnaire.new(:name => "Инженеры", :specialization_id => 9, :is_numeric => false)

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
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'email'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Тел.моб.',
		  		:position => 6,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'phone'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 2,
		  		:value => 'Дата рождения',
		  		:position => 1,
		  		:location => 'right',
		  		:is_necessarily => false
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 3,
		  		:value => 'Проживание',
		  		:position => 2,
		  		:location => 'right',
		  		:is_necessarily => false
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 7,
		  		:value => 'Образование',
		  		:position => 1,
		  		:location => 'center_full',
		  		:is_necessarily => false
		  	)

		question1 = Question.new(
			:position => 6,
			:name => 'Профессиональный опыт',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_values',
			:is_necessarily => false,
			:value => 'Названия объектов, в разработке которых Вы принимали участие'
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

		question2 = Question.new(
			:position => 6,
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

		question3 = Question.new(
			:position => 6,
			:name => '',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_values',
			:is_necessarily => false,
			:value => 'Перечень программ, в которых Вы работаете'
		)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'value',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question3

		question4 = Question.new(
			:position => 7,
			:name => 'Ваш опыт работы в компаниях',
			:count_true => 0,
			:count_all => 0,
			:kind => 'experience_max',
			:is_necessarily => false,
			:value => ''
		)
		question4.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'experience_max',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question4

		question5 = Question.new(
			:position => 1,
			:name => 'Ваши навыки',
			:count_true => 0,
			:count_all => 0,
			:kind => 'check_need',
			:is_necessarily => false,
			:value => ''
		)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер-электрик',
				:value => '',
				:display => 'check_select_no_level',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер ВК',
				:value => '',
				:display => 'check_select_no_level',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер по отоплению',
				:value => '',
				:display => 'check_select_no_level',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер по вентиляции',
				:value => '',
				:display => 'check_select_no_level',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер-конструктор',
				:value => '',
				:display => 'check_select_no_level',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Инженер по слаботочным системам',
				:value => '',
				:display => 'check_select_no_level',
				:position => 6,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question5

		questionnaire.save
	end
end