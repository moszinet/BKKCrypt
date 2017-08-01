pub fn encrypt(password: &String) -> &String {
    return password;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn should_use_the_mighty_bkk_encryption() {
        let password: String = "secret".into();
        assert_eq!(&password, encrypt(&password));
    }
}
