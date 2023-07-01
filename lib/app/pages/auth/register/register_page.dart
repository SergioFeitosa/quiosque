import 'package:quiosque/app/core/ui/base_state/base_state.dart';
import 'package:quiosque/app/core/ui/styles/text_styles.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_appbar.dart';
import 'package:quiosque/app/core/ui/widgets/delivery_button.dart';
import 'package:quiosque/app/pages/auth/register/register_controller.dart';
import 'package:quiosque/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () => {hideLoader(), showError('Erro ao registrar usuário')},
          success: () => {
            hideLoader(),
            showSuccess('Cadastro realizado com sucesso'),
            Navigator.pop(context),
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cadastro',
                      style: context.textStyles.textTitle,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar o seu cadastro',
                      style: context.textStyles.textRegular,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _nameEC,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: Validatorless.required('Nome é obrigatório'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailEC,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Email é obrigatório'),
                          Validatorless.email('Email inválido')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _passwordEC,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Senha é obrigatória'),
                          Validatorless.min(
                              6, 'Senha deve ter no mínimo 6 caracteres')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirmar Senha'),
                      obscureText: true,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Confirme a Senha] '),
                          Validatorless.compare(
                              _passwordEC, 'Senhas não são iguais')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: DeliveryButton(
                        width: double.infinity,
                        label: 'CADASTRAR',
                        onPressed: () {
                          final valid =
                              _formKey.currentState?.validate() ?? false;
                          if (valid) {
                            controller.register(
                                _nameEC.text, _emailEC.text, _passwordEC.text);
                          }
                        },
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
